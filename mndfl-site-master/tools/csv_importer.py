#!/usr/bin/python2.7
"""Parses input CSV and outputs teacher roster.

Spreadsheet here:
https://docs.google.com/spreadsheets/d/1DrVWUQ1RA2MmWtlO4CUUHd3OR5eGDwLvKL2he5XXxYY/edit#gid=0k
"""
import sys
import csv
import json


if __name__ == '__main__':
    # create csv reader
    inf = sys.stdin  # teacher data
    reader = csv.DictReader(f=inf)

    # print teacher information
    def _get_teacher(teacher):
        """Parse DictReader row and make JSON obj. for Angular."""
        result = {}
        for k, v in teacher.iteritems():
            locations = {"Greenwich Village", "Upper East Side",
                         "Williamsburg"}
            if k in locations:
                if v == 'TRUE':
                    if 'locations' not in result:
                        result['locations'] = []
                    result['locations'].append(k)
            else:
                key = k.strip().replace(' ', '_')
                result[key] = v
        if 'locations' in result:
            result['locations_label'] = ', '.join(result['locations'])
        result['booking_link'] = "https://mndfl.zingfit.com/"
        return result

    results = [_get_teacher(row) for row in reader]
    print json.dumps(results, indent=2)

