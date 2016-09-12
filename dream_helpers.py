#!/usr/bin/env python

from __future__ import print_function
from datetime import datetime
import sevenbridges as sbg
import pprint 
pp = pprint.PrettyPrinter(indent=4)

# Working with API object attrs
def get_names(input_list):
    return [i.name for i in input_list]

def get_ids(input_list):
    return [i.id for i in input_list]

# Working with Projects
def get_projects_list(api):
    return list(api.projects.query(limit=None).all())

def get_projects_by_string(api, query):
    return filter(lambda q: query.lower() in q, [p.id for p in get_projects_list(api)])

def get_apps_in_project(api, project):
    return list(api.apps.query(project).all())

def get_files_in_project(api, project):
    return list(api.files.query(project).all())

# Working with Files
def get_files_by_filename_filter(api, project, str_filter=".fq"):
    return filter(lambda q: str_filter.lower() in q.name.lower(), get_files_in_project(api, project))

def get_files_by_metadata(api, project, metadata_filter={"experimental_strategy": "RNA_Seq"}):
    return list(api.files.query(project=project, metadata=metadata_filter, limit=None).all())

def get_files_by_extension(api, project, ext="fq"):
    return [f for f in get_files_in_project(api, project) if f.name.lower().endswith(ext.lower())]

def get_file_by_name(api, project, filename="sim1_mergeSort_1.fq.gz"):
    files = [f for f in api.files.query(project).all() if f.name.lower() == filename.lower()]
    if not files:
        print("No file matching '{}' found in '{}' project.".format(filename, project))
    else:
        return files[0]

def get_files_by_string(api, project, query="sim"):
    files = [f for f in api.files.query(project).all() if query.lower() in f.name.lower()]
    if not files:
        print("No files found.")
        return [None]
    else:
        return files

# Working with Apps
def get_apps_in_project(api, project):
    return list(api.apps.query(project=project).all())

def get_apps_by_string(api, project, query="workflow"):
    apps = [a for a in api.apps.query(project).all() if query.lower() in a.name.lower()]
    if not apps:
        print("No apps found.")
        return [None]
    else:
        return apps

def get_app_by_name(api, project, app_name="DREAM RSEM"):
    apps = [app for app in api.apps.query(project).all() if app.name.lower() == app_name.lower()]
    if not apps:
        print("No app found.")
    else:
        return apps[0]

def get_app_by_id(api, project, app_id="user/project/app/0"):
    apps = [app for app in api.apps.query(project).all() if app.id == app_id]
    if not apps:
        print("No app found.")
    else:
        return apps[0]

# Working with Inputs
def get_input_labels(input_dict):
    return [d.get("label") for d in input_dict]

def get_input_ids(input_dict):
    return [d.get("id") for d in input_dict]

def print_app_inputs(app_object):
    print("Input Ports (labels, IDs): ")
    print(*zip(get_input_labels(app_object.raw['inputs']), get_input_ids(app_object.raw['inputs'])), sep="\n")

def generate_input_object(app_object, required=False, print_opt=False):
    """
    Generates a input object template for submitting tasks
        app_object
        if required = True, get only the input ports without "null" as an acceptable "type"
        if print_opt = True, pretty print to console (for easier copy-pasting)
    """
    if required:
        input_object = dict((str(k['id'].split('#')[-1]), "") for k in app_object.raw['inputs'] if "null" not in k['type'])
    else:
        input_object = dict((str(k['id'].split('#')[-1]), "") for k in app_object.raw['inputs'])
    if print_opt:
        pp.pprint(input_object)
    return input_object

# Sorting - very important for pairing lists of files
def sort_by_name(input_list):
    return input_list.sort(key=lambda x: x.name)

# Filtering lists
def filter_by_prefixes(input_list, filter_list=['sim1a', 'sim8']):
    return [f for f in input_list if f.name.startswith(tuple(filter_list))]

def filter_by_all_strings(input_list, filter_list=['sim', 'isoforms']):
    return [f for f in input_list if all(s in f.name for s in filter_list)]

def filter_by_any_strings(input_list, filter_list=['sim', 'isoforms']):
    return [f for f in input_list if any(s in f.name for s in filter_list)]

# def filter_by_any_metadata(input_list, filter_list=['sim', 'isoforms']):
#     return [f for f in input_list if any(s in f.name for s in filter_list)]

# Working with Fastqs
def get_all_fastqs(api, project, gz=True):
    # Doesn't handle longer filenames
    if gz: 
        return get_files_by_extension(api, project, ext="fq.gz")
    else: 
        return get_files_by_extension(api, project, ext="fq")

def split_fastqs_by_suffix(fastqs):
    # Assumes specific naming convention - sort by name to ensure parity
    fastqs_1 = [fq for fq in fastqs if fq.name.endswith("_1.fq.gz")]
    fastqs_2 = [fq for fq in fastqs if fq.name.endswith("_2.fq.gz")]
    return fastqs_1, fastqs_2

def split_fastqs(fastqs):
    # Assumes specific naming convention - sort by name to ensure parity
    fastqs_1 = [fq for fq in fastqs if fq.metadata['paired_end']=="1"]
    fastqs_2 = [fq for fq in fastqs if fq.metadata['paired_end']=="2"]
    return fastqs_1, fastqs_2

def split_fastqs_tuple(fastqs):
    fastqs_1, fastqs_2 = split_fastqs(fastqs)
    sort_by_name(fastqs_1)
    sort_by_name(fastqs_2)
    check_parity(fastqs_1, fastqs_2)
    return zip(fastqs_1, fastqs_2)

def tuplify_lists_by_name(list1, list2):
    if len(list1) == len(list2):
        sort_by_name(list1)
        sort_by_name(list2)
        check_parity(list1, list2)
        return zip(list1, list2)
    else:
        print("Mistmatched lengths in projects")

# Working with Tasks
def get_tasks_in_project(api, project):
    return list(api.tasks.query(project=project).all())

def get_tasks_by_string(api, project, query="DREAM"):
    tasks = [t for t in api.tasks.query(project=project).all() if query.lower() in t.name.lower()]
    if not tasks:
        print("No tasks found.")
    else:
        return tasks

def get_task_by_name(api, project, task_name="DREAM_kallisto-quant_sim11 - 08-15-2016 14:51:03"):
    tasks = [task for task in api.tasks.query(project).all() if task.name.lower() == task_name.lower()]
    if not tasks:
        print("No task found.")
    else:
        return tasks[0]

def get_task_by_id(api, project, task_id="e3c77cd3-3ba4-4c45-ba42-2670bf17865b"):
    tasks = [task for task in api.tasks.query(project).all() if task.id == task_id]
    if not tasks:
        print("No task found.")
    else:
        return tasks[0]

# Check parity in lists by filename prefix
def check_parity_by_prefix(list1, list2, sep="_"):
    if len(list1) != len(list2):
        print("Mismatched list lengths! {} vs. {}".format(len(list1), len(list2)))
    else:
        for i, l in enumerate(list1):
            if l.name.split(sep)[0] != list2[i].name.split(sep)[0]:
                print("Mismatch detected! {}, {}".format(l.name, list2[i].name))
                break
        # print("Good news, everyone! The tuples are paired nicely (by prefix/before '{}').".format(sep)) 

# Check parity in lists
def check_parity(list1, list2):
    if len(list1) != len(list2):
        print("Mismatched list lengths! {} vs. {}".format(len(list1), len(list2)))
    else:
        for i, l in enumerate(list1):
            if l.metadata['sample_id'] != list2[i].metadata['sample_id']:
                print("Mismatch detected! {}, {}".format(l.name, list2[i].name))
                break
        # print("Good news, everyone! The tuples are paired nicely (by sample id).") 

# Retrieving task status
def refresh_task_status(task_object, print_opt=False):
    task_object.get_execution_details()
    if print_opt:
        print("'{}' status: {}".format(task_object.name, task_object.status))
    return task_object

def refresh_task_status_list(tasks_objects_list, print_opt=False):
    return [refresh_task_status(t, print_opt) for t in tasks_objects_list]

if __name__=="__main__":
    print("DREAM Challenge Helper functions!")