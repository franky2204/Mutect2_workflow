import os
from tqdm import tqdm
from collections import defaultdict

# Load the GTF file into an array
array = []

with open('Homo_sapiens.GRCh38.110.gtf', 'r') as file:
    for line in file:
        if not line.startswith('#'):
            array.append(line.strip().split('\t'))

# Create a dictionary to store exon information
util = defaultdict(list)

# Extract exon information from the array
for elem in tqdm(array):
    if elem[2] == 'exon':
        exon = ''
        gene_name = ''
        for obj in elem[8].split(';'):
            if 'exon_id' in obj:
                exon = obj.split(' ')[-1].replace('"', '')
            elif 'gene_name' in obj:
                gene_name = obj.split(' ')[-1].replace('"', '')
        key = (f'chr{elem[0]}', int(elem[3]), int(elem[4]))
        if not util[key]:
            util[key] = [exon, elem[1], gene_name]

# Create a dictionary to correct the structure
correct_dict = defaultdict(list)

for key, values in tqdm(util.items()):
    correct_dict[key[0]].append([key[1], key[2], values])

# Load the sample data
samples = []
with open('daniela.tsv', 'r') as file:
    for line in file:
        samples.append(line.strip().split('\t'))

samples[0].extend(['HAVANA', 'EXON_ID', 'GENE'])

obj = [samples[0]]

# Match samples with exon data
for elem in tqdm(samples):
    if len(elem) > 2 and elem[1] in correct_dict:
        for tmp in correct_dict[elem[1]]:
            if tmp[0] < int(elem[2]) < tmp[1]:
                array_tmp = elem[:]
                array_tmp.extend([tmp[2][1], tmp[2][0], tmp[2][2]])
                obj.append(array_tmp)

# Create a set to store unique combinations
prova = set()

for ob in obj:
    if len(ob) > 9:  # Ensure there are enough elements
        prova.add((ob[1], ob[2], ob[9]))

# Write results to a file
with open('results.tsv', 'w') as file:
    for elem in obj:
        file.write('\t'.join(elem) + '\n')

# Create a set for excluded samples
excluded = set()
new_obj = [elem[:-3] for elem in obj]

for elem in tqdm(samples):
    if len(elem) > 2 and elem not in new_obj:
        excluded.add('\t'.join(elem))

# Create a dictionary to store transcript information
util_transcript = defaultdict(list)

for elem in tqdm(array):
    if elem[2] == 'transcript':
        transcript = ''
        gene_name = ''
        for obj in elem[8].split(';'):
            if 'transcript_id' in obj:
                transcript = obj.split(' ')[-1].replace('"', '')
            elif 'gene_name' in obj:
                gene_name = obj.split(' ')[-1].replace('"', '')
        key = (f'chr{elem[0]}', int(elem[3]), int(elem[4]))
        if not util_transcript[key]:
            util_transcript[key] = [transcript, elem[1], gene_name]

# Create a dictionary to correct the structure for transcripts
correct_dict_transcript = defaultdict(list)

for key, values in tqdm(util_transcript.items()):
    correct_dict_transcript[key[0]].append([key[1], key[2], values])

# Match excluded samples with transcript data
obj_transcript = []

for elem in tqdm(excluded):
    elem = elem.split('\t')
    if len(elem) > 2 and elem[1] in correct_dict_transcript:
        for tmp in correct_dict_transcript[elem[1]]:
            if tmp[0] < int(elem[2]) < tmp[1]:
                array_tmp = elem[:]
                array_tmp.extend([tmp[2][1], tmp[2][0], tmp[2][2]])
                obj_transcript.append(array_tmp)

# Create a set to store unique transcript combinations
prova = set()

for ob in obj_transcript:
    if len(ob) > 9:  # Ensure there are enough elements
        prova.add((ob[1], ob[2], ob[9]))

# Write transcript results to a file
with open('results_transcript.tsv', 'w') as file:
    for elem in obj_transcript:
        file.write('\t'.join(elem) + '\n')

