import re
import hashlib

def readlines_file(file_name):
    # 行毎のリストを返す
    with open(file_name, 'r') as file:
        return file.readlines()

def read_file(file_name):
    with open(file_name, 'r') as file:
        return file.read()


def save_file(file_name, text):
    with open(file_name, 'w') as file:
        file.write(text)

lines = read_file('Natural_Activity_act_list.tsv').split('\n') # .splitでlist
#lines = readlines_file('Natural_Activity_act_list.tsv') 

# 空行の削除
lines = list(filter(lambda line: line != '', lines))

# 不要行の削除
pattern20=re.compile(r'activity\tsp2') 
lines = [x for x in lines if re.sub('activity\tsp2', r'', x)]
pattern00=re.compile(r'\(1939\srows\)') 
lines = [x for x in lines if re.sub('\(1939\srows\)', r'', x)]

"""
# 指定列の取り出し01 採番
nmb = []
for i, line in enumerate(lines, 1):
  i = f'{i:04}'
  nmb.append(i)

pattern22=re.compile(r'(^.+)') 
nmb = [re.sub('^(.+)', r'<http://purl.jp/knapsack/activity#\1>\t<http://www.w3.org/2000/01/rdf-schema#label>', x) for x in nmb]
"""

# 指定列の取り出し01.5 md5化
cal0 = list(map(lambda line: line.split('\t')[0], lines))
cal0 = [hashlib.md5(i.encode('utf-8')).hexdigest() for i in cal0]
cal0 = [re.sub('^(.+)', r'<http://purl.jp/knapsack/activity#\1>\t<http://www.w3.org/2000/01/rdf-schema#label>', x) for x in cal0]


# 指定列の取り出し02
cal1 = list(map(lambda line: line.split('\t')[0], lines))

pattern22=re.compile(r'(^.+)') 
cal1 = [re.sub('^(.+)', r'"\1"@en ;\t<http://purl.jp/knapsack/property/sp2>', x) for x in cal1]

# 指定列の取り出し03
cal2 = list(map(lambda line: line.split('\t')[1], lines))

pattern23=re.compile(r'\/') 
cal2 = [re.sub('\/', r'"@en , "', x) for x in cal2]
pattern24=re.compile(r'^(.)') 
cal2 = [re.sub('^(.)', r'"\1', x) for x in cal2]
pattern25=re.compile(r'(.)$') 
cal2 = [re.sub('(.)$', r'\1"@en .', x) for x in cal2]

#print(lines)
#print(nmb)

#print(type(nmb))

#.joinで，改行で'\n'で行を連結， .joinで，空文字列''で行を単純連結
# 検証用 save_file('Natural_Activity_act_list_lines.txt', "\n".join(lines)) 
# 検証用 save_file('Natural_Activity_act_list_nmb.txt', "\n".join(nmb))
# 検証用 save_file('Natural_Activity_act_list_cal0.txt', "\n".join(cal0))  
# 検証用 save_file('Natural_Activity_act_list_cal1.txt', "\n".join(cal1))
# 検証用 save_file('Natural_Activity_act_list_cal2.txt', "\n".join(cal2))


# 改行や空白文字を削除
#nmb = list(map(lambda x: x.strip(), nmb)) # mapでlistを作成
cal0 = list(map(lambda x: x.strip(), cal0)) # mapでlistを作成
cal1 = list(map(lambda x: x.strip(), cal1)) # mapでlistを作成
cal2 = list(map(lambda x: x.strip(), cal2)) # .strip()で文頭，文末のスペース，改行を削除

# タブ区切りで並べたリストを作成 zipで複数のシーケンスオブジェクトを同時にループ
lines_ttl = ["{0}\t{1}\t{2}".format(line0, line1, line2) for line0, line1, line2 in zip(cal0, cal1, cal2)]

lines_ttl = list(set(lines_ttl)) # 重複削除
lines_ttl = sorted(lines_ttl) # 並べ替え

#.joinで，改行'\n'で行を連結, .joinで，空文字列''で行を単純連結
save_file('md5Activity_Species_fromNatural_Activity_act_list.ttl', "\n".join(lines_ttl)) # .joinで，改行'\n'で行を連結

###

# 参照: https://www.suzu6.net/posts/21/
# 参照: https://www.suzu6.net/posts/22/
