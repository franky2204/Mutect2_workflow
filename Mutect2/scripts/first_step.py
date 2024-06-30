from tqdm import tqdm
from collections import defaultdict
import csv
import sys

elements = defaultdict(list)
patients = []

# CHROM 0
# POS 1
# REF 3
# ALT 4
# INFO 7
# FORMAT 8
# PATIENTS 9:

with open(sys.argv[1], 'r') as file:
    for line in tqdm(file):
        tmp = {}
        if not line.startswith('##'):
            if line.startswith('#'):
                patients = [elem.split('/')[-1] for elem in line.split('\t')][9:]
            else:
                array = line.split('\t')
                tmp['chr'] = array[0]
                tmp['pos'] = array[1]
                tmp['ref'] = array[3]
                tmp['alt'] = array[4]
                tmp['info'] = array[7]
                tmp['format'] = array[8]
                pat_num = 0
                pat = {}
                for elem in array[9:]:
                    # if (not './.' in elem and not '0/0' in elem) or ((tmp['chr'], int(tmp['pos'])) in filter_chr_pos):
                    # if not './.' in elem and not '0/0' in elem:
                    if not './.' in elem:
                        pat[patients[pat_num].replace('\n', '')] = elem
                    pat_num += 1
                tmp['patients'] = pat
                elements[(tmp['chr'], tmp['pos'], tmp['info'])] = tmp


str_arr = []
for key in tqdm(elements.keys()):
    tmp_info = {}
    info = elements[key]['info'].split(';')
    for obj in info:
        tmp_obj = obj.split('=')
        if tmp_obj[0] == 'DP':
            tmp_info[tmp_obj[0]] = tmp_obj[1]
    elements[key]['info'] = tmp_info

    tmp_format = {}
    format = elements[key]['format'].split(':')
    for obj in format:
        if obj == 'GT':
            tmp_format[obj] = format.index(obj)
        elif obj == 'AD':
            tmp_format[obj] = format.index(obj)
        elif obj == 'DP':
            tmp_format[obj] = format.index(obj)
        elif obj == 'AF':
            tmp_format[obj] = format.index(obj)
    elements[key]['format'] = tmp_format

    tmp_patients_dict = {}
    tmp_patients = elements[key]['patients']
    for key3 in tmp_patients.keys():
        tmp = tmp_patients[key3].split(':')
        for key2, values in elements[key]['format'].items():
            tmp_patients_dict[key2] = tmp[values]

        str_arr.append([key3, elements[key]['chr'], elements[key]['pos'], elements[key]['ref'], elements[key]['alt'], elements[key]['info']['DP'], tmp_patients_dict['GT'], tmp_patients_dict['AD'], tmp_patients_dict['DP'], tmp_patients_dict['AF']])


with open('daniela.tsv', 'w') as f:
    # create the csv writer
    writer = csv.writer(f, delimiter='\t')

    # write a row to the csv file
    writer.writerow(['Pat', 'CHR', 'POS', 'REF', 'ALT', 'DP_INFO', 'GT', 'AD', 'DP_FORMAT', 'AF'])
    writer.writerows(str_arr)
