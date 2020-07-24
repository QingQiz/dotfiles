#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from threading import Thread
from multiprocessing import Pool


def init(job=1):
    def do_with_retry(n, act, args):
        while n >= 0:
            try:
                return act(*args)
            except:
                n -= 1


    def parallel_in_process(target, params_list):
        global lambda_to_function
        def lambda_to_function(params):
            return do_with_retry(3, target, params)

        return Pool(job).map(lambda_to_function, params_list)


    def parallel_in_thread(target, params_list):
        length = len(params_list)
        step = (length + job - 1) // job

        result = [None for i in range(length)]

        def action(j):
            for i in range(step * j, min(length, step * (j + 1))):
                params = params_list[i]
                result[i] = (do_with_retry(3, target, params))

        pool = [Thread(target=action, args=(i,)) for i in range(job)]

        [i.start() for i in pool]
        [i.join() for i in pool]

        return result


    def parallel_run(target, params_list, thread=True):
        if len(params_list) == 0:
            return []

        if job <= 1:
            return [target(*i) for i in params_list]

        if thread:
            res = parallel_in_thread(target, params_list)
        else:
            res = parallel_in_process(target, params_list)
        return res

    return parallel_run
