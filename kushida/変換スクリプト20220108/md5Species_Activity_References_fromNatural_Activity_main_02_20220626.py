import re
import urllib.parse
import hashlib

def read_file(file_name):
    with open(file_name, 'r') as file:
        return file.read()

def readlines_file(file_name):
    # 行毎のリストを返す
    with open(file_name, 'r') as file:
        return file.readlines()


def save_file(file_name, text):
    with open(file_name, 'w') as file:
        file.write(text)


lines = read_file('Natural_Activity_main_rev.tsv').split('\n') # .splitでstrからlist

# 空行の削除
lines = list(filter(lambda line: line != '', lines))

# 不要行の削除
pattern0=re.compile(r'sp\tactivity\treference') 
lines = [x for x in lines if re.sub('sp\tactivity\treference', r'', x)]
pattern00=re.compile(r'\(1432\srows\)') 
lines = [x for x in lines if re.sub('\(1432\srows\)', r'', x)]

# 指定列の取り出し
cal1 = list(map(lambda line: line.split('\t')[0], lines))
cal2 = list(map(lambda line: line.split('\t')[1], lines))

# 検証用 save_file('Natural_Activity_main_cal1.txt', "\n".join(cal1))
# 検証用 save_file('Natural_Activity_main_cal2.txt', "\n".join(cal2))
#save_file('Natural_Activity_main02.tsv', "\n".join(lines))

###

pattern03=re.compile(r'(^.+)') 
cal1_literal = [re.sub('^(.+)', r'"\1"', x) for x in cal1]


"""
# URLエンコード
#cal1_url = [urllib.parse.quote(i) for i in cal1]
cal1_url = [urllib.parse.quote(i, safe='\n') for i in cal1]
"""

# md5
cal1_md5species = [hashlib.md5(i.encode('utf-8')).hexdigest() for i in cal1]

pattern03=re.compile(r'(^.+)') 
cal1_md5species_sp = [re.sub('^(.+)', r'<http://purl.jp/knapsack/annotation#\1>\t<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>\t<http://purl.jp/knapsack/KNApSAcKCoreAnnotation> ;\t<http://purl.jp/knapsack/sp>', x) for x in cal1_md5species]
cal1_md5species_act = [re.sub('^(.+)', r'<http://purl.jp/knapsack/annotation#\1>\t<http://purl.jp/knapsack/proterty/activity>', x) for x in cal1_md5species]

# 検証用 save_file('Natural_Activity_cal1_md5species_act.txt', "\n".join(cal1_md5species_act))

###

# cal2の不要行の削除

pattern05=re.compile(r'(\))\(') 
cal2 = [re.sub('(\))\(', r'\1"@en, "', x) for x in cal2]
pattern06=re.compile(r"""([a-zA-Z])\s{0,1}\(([^+-])""") 
cal2 = [re.sub("""([a-zA-Z])\s{0,1}\(([^+-])""", r"""\1"@en, "\2""", x) for x in cal2]
#pattern07=re.compile(r"""([a-zA-Z])\s{0,1}\(([^+-])""") 
cal2 = [re.sub('\"\@en\,\s\"(peripheral|breast|colon|pediatric|pain|snake|araceae|mushroom|seafood poisoning|cat repellant|dog repellant|fluorine|nux-vomica|scorpion|poison|narcotic|varnish|opiate|alkaloid|fish|shellfish|atropine|aluminum|curare|daylily|crab|physostigmine|strychnine|mercury|quicksilver|lead|Hg|nicotine|arsenic|alcohol|opium|aluminum|cadmium|paraquat|hippomane|nettle|spider|stingray|food poisoning|poison|beryllium|fish poison|strychnine|narcotics|hemlock|Cassava|Jatropha|Rhus|Strophanthus|abrin|barbituate|morphine|cinnabar|Pain)\)\"\@en\,\s', r' (\1)"@en, ', x) for x in cal2]
pattern08=re.compile(r'\)\;') 
cal2 = [re.sub('\)\;', r'"@ja, "', x) for x in cal2]
pattern09=re.compile(r'\)$') 
cal2 = [re.sub('\)$', r'"@ja.', x) for x in cal2]
pattern10=re.compile(r'^(.)') 
cal2 = [re.sub('^(.)', r'"\1', x) for x in cal2]
pattern11=re.compile(r'(Secretolytic|Candidicide|Memorigenic|Circulostimulant|Juvabional|Pulmonotonic|Tracheorelaxant|Propecic)$') 
cal2 = [re.sub('(Secretolytic|Candidicide|Memorigenic|Circulostimulant|Juvabional|Pulmonotonic|Tracheorelaxant|Propecic)$', r'\1"@en.', x) for x in cal2]

# 検証用 save_file('Natural_Activity_main_cal2_http.txt', "\n".join(cal2))

###

# 改行や空白文字を削除
cal1_md5species_sp = list(map(lambda x: x.strip(), cal1_md5species_sp)) # mapでlistを作成
cal1_literal = list(map(lambda x: x.strip(), cal1_literal)) # mapでlistを作成
cal1_md5species_act = list(map(lambda x: x.strip(), cal1_md5species_act)) # mapでlistを作成
cal2 = list(map(lambda x: x.strip(), cal2)) # .strip()で文頭，文末のスペース，改行を削除

# タブ区切りで並べたリストを作成 zipで複数のシーケンスオブジェクトを同時にループ
lines_ttl = ["{0}\t{1} . \n{2}\t{3}".format(line1, line2, line3, line4) for line1, line2, line3, line4 in zip(cal1_md5species_sp, cal1_literal, cal1_md5species_act, cal2)]

# .joinで，改行'\n'で行を連結，空文字列''で行を単純連結
save_file('md5Species_Activity_References_fromNatural_Activity_main_02.ttl', "\n".join(lines_ttl)) 

###

# 参照: https://www.suzu6.net/posts/21/
# 参照: https://www.suzu6.net/posts/22/
