from datetime import date, timedelta
from optparse import OptionParser



def get_conference_code_dict():
    conference_code_dict = {
     'America East': 99,
     'Atlantic Coast': 6,
     'Atlantic Ten': 101,
     'Atlantic Sun': 107,
     'American Athletic': 201,
     'Big 12': 103,
     'Big East': 102,
     'Big Sky': 15,
     'Big South': 16,
     'Big Ten': 3,
     'Big West': 8,
     'Colonial Athletic': 17,
     'Conference USA': 1,
     'Horizon League': 34,
     'Independents': 35,
     'Ivy League': 18,
     'Metro Atlantic Athletic': 19,
     'Mid-American': 20,
     'Mid-Eastern': 31,
     'Missouri Valley': 21,
     'Mountain West': 112,
     'Northeast': 32,
     'Ohio Valley': 23,
     'Pac-12':  2,
     'Patriot League': 24,
     'Southeastern': 10,
     'Southland': 28,
     'Southwestern Athletic': 105,
     'Summit': 194,
     'Sun Belt': 5,
     'West Coast': 110,
     'Western Athletic': 111
    }
    return conference_code_dict





def main():
    # Get year, month, day args for yesterday.
    yesterday = date.today() - timedelta(1)
    year = yesterday.year
    month = yesterday.month
    day = yesterday.day

    parser = OptionParser()
    parser.add_option('-y', '--year', dest='year',
                      help='Year of data to acquire.', default='')
    parser.add_option('-m', '--month', dest='month',
                      help='Month of data to acquire.',
                      default='')
    parser.add_option('-d', '--day', dest='day',
                      help='Day of data to acquire.',
                      default='')

    # Get year month day from options.
    (options, args) = parser.parse_args()
    if options.year != '':
        year = int(options.year)
    if options.month != '':
        month = int(options.month)
    if options.day != '':
        day = int(options.day)

    # If year, month, day args are not full defined, use yesterday.
    if year == None or month == None or day == None:
        yesterday = date.today() - timedelta(1)
        year = yesterday.year
        month = yesterday.month
        day = yesterday.day

    msg = str.format('Starting data acquisition for {0}-{1}-{2}...',
        str(year), str(month), str(day) )
    print msg




main()

