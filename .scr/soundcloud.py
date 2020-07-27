#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from QingQiz import *

import requests
import re
import json
import os
import sys
import functools
import operator
from shutil import which

DEBUG = 0

s = requests.Session()


def get_sndcd_apikey():
    log.i('Get apikey...')
    r = netreq.url_html('https://soundcloud.com', s=s)
    x = re.findall(r'script crossorigin src="(.+?)"></script>', r)

    r = netreq.url_html(x[-1], s=s)
    x = re.search(r'client_id:"(.+?)"', r)

    return x.group(1)


def get_resource_info(resource_url, client_id, resource=None):
    if resource is None:
        r = netreq.url_html(resource_url, encoding='utf-8')

        x = re.escape('forEach(function(e){n(e)})}catch(t){}})},')
        x = re.search(r'' + x + r'(.*)\);</script>', r)

        info = json.loads(x.group(1))[-1]['data'][0]
    else:
        info = resource

    info = info['tracks'] if info.get('track_count') else [info]

    ids = [i['id'] for i in info if i.get('comment_count') is None]
    ids = list(map(str, ids))
    ids_split = ['%2C'.join(ids[i:i+10]) for i in range(0, len(ids), 10)]
    api_url = 'https://api-v2.soundcloud.com/tracks?ids={ids}&client_id={client_id}&%5Bobject%20Object%5D=&app_version=1584348206&app_locale=en'

    urll = [api_url.format(ids=ids, client_id=client_id) for ids in ids_split]

    log.i('Get resource info')
    res = netreq.urls_json(urll, s=s)

    if res:
        res = functools.reduce(operator.iconcat, res)

    res = iter(res)

    info = [next(res) if i.get('comment_count') is None else i for i in info]

    return info


def download(resource_info, client_id):
    for info in resource_info:
        name = info['title']
        name = name.replace('/', '、').replace('\\', '、')
        name = name.replace(':', '：').replace('?', '？')
        name = name.replace('"', "'").replace('*', '·')
        name = name.replace('<', '[').replace('>', ']')
        name = name.replace('|', '丨')
        
        metadata = info['publisher_metadata']

        transcodings = info['media']['transcodings']
        sq = [i for i in transcodings if i['quality'] == 'sq']
        hq = [i for i in transcodings if i['quality'] == 'hq']
        surl = sq[0] if hq == [] else hq[0]
        surl = surl['url']

        uri = surl + '?client_id=' + client_id
        surl = netreq.url_json(uri, s=s)['url']

        log.i('Get m3u8 playlist...')
        m3u8 = netreq.url_html(surl, s=s)
        urll = re.findall(r'http.*?(?=\n)', m3u8)

        log.i(f'Download {name}...')
        resource = b''.join(netreq.urls_content(urll, s=s))

        artwork = info.get('artwork_url')
        if artwork:
            artwork = artwork.replace('large', 't500x500')
            r = netreq.url_content(artwork, s=s)
            if r == 'not found':
                artwork = artwork.replace('t500x500', 'large')
                r = netreq.url_content(artwork, s=s)

        yield {
            'title': name,
            'sound': resource,
            'artwork': r,
            'metadata': metadata
        }


def add_metadata(sound_name, image_name, metadata):
    if which('ffmpeg') == None:
        return

    log.i('Add metadata...')
    metadata_opt = ' '
    for i in metadata:
        metadata_opt += f'-metadata {i}="{metadata[i]}" '

    cmd = 'ffmpeg -i "file:{sound}" -i "file:{img}" -map 0:0 -map 1:0 -codec copy -id3v2_version 3 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (font)" {metadata} -loglevel quiet -y "file:{output}"'
    os.system(cmd.format(sound=sound_name, img=image_name, output='bak.'+sound_name, metadata=metadata_opt))

    if os.path.exists('bak.' + sound_name):
        os.remove(sound_name)
        os.rename("bak." + sound_name, sound_name)
        os.remove(image_name)


def dump_download(downloaded):
    with open(downloaded['title'] + '.mp3', 'wb') as f:
        f.write(downloaded['sound'])

    if len(downloaded['artwork']) < 20:
        return

    with open(downloaded['title'] + '.jpg', 'wb') as f:
        f.write(downloaded['artwork'])

    if downloaded['metadata'] is None:
        downloaded['metadata'] = {}

    add_metadata(
        downloaded['title'] + '.mp3',
        downloaded['title'] + '.jpg',
        downloaded['metadata']
    )


def sndcd_search(q, client_id):
    url = 'https://api-v2.soundcloud.com/search'
    param = {
        "q": q,
        "client_id": client_id,
        "limit": 20,
        "offset": 0,
    }

    tracks = netreq.url_json(url, encoding='utf-8', params=param)
    total = tracks['total_results']
    tracks = [i for i in tracks['collection'] if i.get('kind') in ['playlist', 'track']]

    print(f'Found {len(tracks)} of {total}')
    for index, info in enumerate(tracks):
        duration = info.get('duration')
        duration = info.get('full_duration') if duration is None else duration
        duration = int(duration) // 1000
        print(f'{index+1:02} {duration:5}s {info["kind"]:>8}  {info["title"]}')

    return tracks


if __name__ == '__main__':
    assert len(sys.argv) >= 2, f'usage: python3 {sys.argv[0]} <url>'
    # url = 'https://soundcloud.com/anthony-flieger/sets/cytus'
    # url = 'https://soundcloud.com/keiny-pham/impure-bird'
    url = sys.argv[1]

    client_id = get_sndcd_apikey()

    if url.find('https://soundcloud.com/') == 0:
        info = get_resource_info(url, client_id)
    else:
        q = ' '.join(sys.argv[1:])
        info = sndcd_search(q, client_id)

        print('\nType id to download (for example 01): __\b\b', end='')
        try:
            idx = input()
            info = info[int(idx) - 1]
        except KeyboardInterrupt:
            print('Interrupted')
            exit(-1)
        except (IndexError, ValueError):
            print('Wrong input')
            exit(-1)

        info = get_resource_info(url, client_id, info)

    for downloaded in download(info, client_id):
        dump_download(downloaded)

