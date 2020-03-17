#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests
import re
import os
import sys
from shutil import which

proxy = {
    'http': 'http://127.0.0.1:1080',
    'https': 'http://127.0.0.1:1080'
}

def add_albumart(sound_name, image_name):
    if which('ffmpeg') == None:
        os.remove(image_name)
        return

    os.rename(sound_name, "/tmp/" + sound_name)
    cmd = 'ffmpeg -i "file:{sound}" -i "file:{img}" -map 0:0 -map 1:0 -codec copy -id3v2_version 3 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (font)" -loglevel quiet -y "file:{output}"'
    os.system(cmd.format(sound="/tmp/"+sound_name, img=image_name, output=sound_name))
    os.rename(image_name, '/tmp/' + image_name)


def get_resource_info(soundcloud_url):
    s = requests.Session()
    s.proxies.update(proxy)

    r = s.get('https://sclouddownloader.net/')

    s.headers.update(Referer='https://sclouddownloader.net/')

    r = s.post('https://sclouddownloader.net/download-sound-track', data={
        "csrfmiddlewaretoken": s.cookies.get_dict()['csrftoken'],
        "sound-url": soundcloud_url
    })

    sound_url = re.search(r'<a href="(.*)" class=.*Manually', r.text).group(1)
    sound_url = sound_url.replace('&amp;', '&')
    image_url = re.search(r'<img id="thumbnail" src="(.*)" style', r.text).group(1)
    image_url = image_url.replace('&amp;', '&')

    name = re.search(r'<i>(.*)\.mp3</i>', r.text).group(1)
    name = name if name[-4:] == '.mp3' else name + '.mp3'
    name = name.replace('&amp;', '&')

    return {'thumbnail': image_url, 'sound': sound_url, 'title': name}


def download_resource_data(resource_info):
    image_url = resource_info['thumbnail']
    sound_url = resource_info['sound']
    image_name = image_url[image_url.find('artworks'):].replace('/', ' ')
    sound_name = resource_info['title'].replace('/', ' ')

    print('downloading image...')
    r = requests.get(image_url, proxies=proxy)
    image_data = r.content

    print('downloading sound...')
    r = requests.get(sound_url, proxies=proxy)
    sound_data = r.content

    with open(sound_name, 'wb') as f:
        f.write(sound_data)

    if len(image_data) > 100:
        with open(image_name, 'wb') as f:
            f.write(image_data)
        add_albumart(sound_name, image_name)


if __name__ == '__main__':
    assert len(sys.argv) == 2, 'usage: python3 soundcloud.py <url>'
    url = sys.argv[1]

    assert url.find('https://soundcloud.com/') == 0, 'my name is SOUNDCLOUD.PY'

    print('getting resource info...')
    resource_info = get_resource_info(url)
    print(f"image url:  {resource_info['thumbnail'][:50]}...")
    print(f"sound url:  {resource_info['sound'][:50]}...")
    download_resource_data(resource_info)

