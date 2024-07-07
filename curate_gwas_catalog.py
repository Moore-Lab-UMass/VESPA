from absl import app
from absl import flags

import pandas as pd

FLAGS = flags.FLAGS
flags.DEFINE_string('catalog', None, 'Path to dbSNP study catalog tsv file.')
flags.DEFINE_string('output', None, 'Path to write the population annotated and aggregated tsv.')


POP_DICT = {
    "European":"eur",
    "Finnish":"eur",
    "British":"eur",
    "Chinese":"asn",
    "Japanese":"asn",
    "Asian":"asn",
    "Indian":"asn",
    "Filipino":"asn",
    "African":"afr",
    "Latin":"amr",
    "Latino": "amr",
    "Hispanic":"amr",
    "Swedish":"eur",
    "Icelandic":"eur",
    "Irish":"eur",
    "Danish":"eur",
    "Scottish":"eur",
    "Dutch":"eur",
    "Korean":"asn",
    "Taiwanese":"asn",
    "Kenyan":"afr",
    "Thai":"asn",
    "Austrian":"eur",
    "Mexican":"amr",
    "Hispanic/Latino":"amr",
    "German":"eur",
    "Polish":"eur",
    "Italian":"eur","Norwegian":"eur",
    "Thai-Chinese":"asn",
    "HIspanic/Latino":"amr" #typo here is intentional
}


OUT_COLS = [
    'DISEASE/TRAIT',
    'PUBMEDID',
    'FIRST_AUTHOR',
    'DISEASE_TRAIT',
    'POPULATION'
]


def map_to_pop(sample):
    if "African American" in sample or "Jewish" in sample:
        return 'unsure'
    else:
        populations=set()
        for word in sample.split():
            if word in POP_DICT:
                populations.add(POP_DICT[word])
        if len(populations) == 0:
            return "unsure"
        elif len(populations) == 1:
            return populations.pop()
        else:
            return "mixed"


def main(argv):
    del argv  # Unused.

    df = pd.read_csv(FLAGS.catalog, sep='\t')
    df['DISEASE_TRAIT'] = df['DISEASE/TRAIT'].map(lambda x: '_'.join(x.split(' ')))
    df['FIRST_AUTHOR'] = df['FIRST AUTHOR'].map(lambda x: '_'.join(x.split(' ')))
    df['POPULATION'] = df['INITIAL SAMPLE SIZE'].map(str).map(map_to_pop)
    filtered = df[~df['POPULATION'].isin(['unsure', 'mixed'])]
    aggregated = filtered.groupby(['PUBMEDID', 'DISEASE/TRAIT'], as_index=False).first()[OUT_COLS]
    aggregated.to_csv(FLAGS.output, sep='\t', index=False)


if __name__ == '__main__':
    flags.mark_flags_as_required(['catalog', 'output'])
    app.run(main)
