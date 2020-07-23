#!/usr/bin/env python3
# -*- coding: utf-8 -*-


def init(job=1):
    def parallel_in_process(target, params_list):
        from multiprocessing import Pool
    
        global lambda_to_function
        def lambda_to_function(params):
            return target(*params)
    
        return Pool(job).map(lambda_to_function, params_list)
    
    
    def parallel_in_thread(target, params_list, sort):
        import queue
        from threading import Thread
    
        tasks = queue.Queue()
        result = queue.Queue()
    
        for i in (params_list if not sort else enumerate(params_list)):
            tasks.put(i)
    
        def action_sort():
            while not tasks.empty():
                try:
                    idx, params = tasks.get(block=False)
                    result.put((idx, target(*params)))
                except:
                    tasks.put((idx, params))
    
        def action_not_sort():
            while not tasks.empty():
                try:
                    params = tasks.get(block=False)
                    result.put(target(*params))
                except:
                    tasks.put(params)
    
        def action():
            try:
                if sort:
                    action_sort()
                else:
                    action_not_sort()
            except queue.Empty:
                return
    
        pool = [Thread(target=action) for i in range(job)]
    
        [i.start() for i in pool]
    
        ret = [result.get() for i in range(len(params_list))]
    
        if not ret:
            return []
    
        if sort:
            ret = sorted(ret)
            return list(zip(*ret))[1]
        return ret
    
    
    def parallel_run(target, params_list, sort_result=False, use_thread=True):
        if len(params_list) == 0:
            return []
    
        if job <= 1:
            return [target(*i) for i in params_list]
    
        if use_thread:
            res = parallel_in_thread(target, params_list, sort_result)
        else:
            res = parallel_in_process(target, params_list)
        return res

    return parallel_run
    
    
    
