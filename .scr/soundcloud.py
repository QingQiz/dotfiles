#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import requests
import re
import json
import os
import sys
from shutil import which

DEBUG = 0
proxy = {
    'http': 'http://127.0.0.1:1080',
    'https': 'http://127.0.0.1:1080'
}

s = requests.Session()
s.proxies.update(proxy)

def D(s='', end='\n'):
    if not DEBUG:
        return
    print(s if len(s) < 80 else (s[:80] + '...'), end=end)


def get_sndcd_apikey():
    D('GET: https://soundcloud.com')
    r = s.get('https://soundcloud.com')
    x = re.findall(r'script crossorigin src="(.+?)"></script>', r.text)

    D(f'GET: {x[-1]}')
    r = s.get(x[-1])
    x = re.search(r'client_id:"(.+?)"', r.text)

    return x.group(1)


def get_resource_info(resource_url, client_id, resource=None):
    if resource is None:
        D('GET: ' + resource_url)
        r = s.get(resource_url)
        r.encoding = 'utf-8'

        x = re.escape('forEach(function(e){n(e)})}catch(t){}})},')
        x = re.search(r'' + x + r'(.*)\);</script>', r.text)

        info = json.loads(x.group(1))[-1]['data'][0]
    else:
        info = resource

    info = info['tracks'] if info.get('track_count') else [info]

    ids = [i['id'] for i in info if i.get('comment_count') is None]
    ids = list(map(str, ids))
    ids_split = ['%2C'.join(ids[i:i+10]) for i in range(0, len(ids), 10)]
    api_url = 'https://api-v2.soundcloud.com/tracks?ids={ids}&client_id={client_id}&%5Bobject%20Object%5D=&app_version=1584348206&app_locale=en'

    res = []
    for ids in ids_split:
        uri = api_url.format(ids=ids, client_id=client_id)
        D(f'GET: {uri}')
        r = s.get(uri)
        r.encoding = 'utf-8'
        res += json.loads(r.text)
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
        
        artwork = info['artwork_url']
        artwork = artwork.replace('large', 't500x500')
        metadata = info['publisher_metadata']

        print('Dowload: ' + name)

        transcodings = info['media']['transcodings']
        sq = [i for i in transcodings if i['quality'] == 'sq']
        hq = [i for i in transcodings if i['quality'] == 'hq']
        surl = sq[0] if hq == [] else hq[0]
        surl = surl['url']

        uri = surl + '?client_id=' + client_id
        D(f'GET: {uri}')
        r = s.get(uri)
        surl = json.loads(r.text)['url']

        D(f'GET: {surl}')
        m3u8 = s.get(surl)
        m3u8 = m3u8.text
        urll = re.findall(r'http.*?(?=\n)', m3u8)

        resource = b''
        for url in urll:
            D(f'GET: {url}')
            r = s.get(url)
            resource += r.content

        D('GET: ' + artwork, end='')
        r = s.get(artwork)
        if r.text == 'not found':
            D('...not found', end='')
            artwork = artwork.replace('t500x500', 'large')
            r = s.get(artwork)
        D()

        yield {
            'title': name,
            'sound': resource,
            'artwork': r.content,
            'metadata': metadata
        }


def add_metadata(sound_name, image_name, metadata):
    if which('ffmpeg') == None:
        return

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

    D(f"GET: {url}")
    r = s.get(url, params=param)
    r.encoding = 'utf-8'
    tracks = json.loads(r.text)
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

