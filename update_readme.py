import time
from datetime import datetime
from datetime import date

now = datetime.now()
curr_date = datetime.now().date()
this_year = datetime.now().year
start_of_this_year = date(this_year, 1, 1)
end_of_this_year = date(this_year, 12, 31)
progress_of_this_year = (curr_date - start_of_this_year) / (end_of_this_year - start_of_this_year)


def generate_progress_bar():
    progress_bar_capacity = 30
    passed_progress_bar_index = int(progress_of_this_year * progress_bar_capacity)
    passed_progress_bar = '█' * passed_progress_bar_index
    left_progress_bar = '▁' * (30 - passed_progress_bar_index)
    return " { " + passed_progress_bar + left_progress_bar + " } " + "%.2f" % (progress_of_this_year * 100) + " %"


bar = generate_progress_bar()
update_time = time.strftime('%Y-%m-%d %H:%M:%S')

with open("README.md", 'w', encoding='utf8') as f:
    f.write("### Hi there 👋\n\n⏳ Year progress " + bar + "\n\n⏰ Updated on " + update_time
            + " with Python.\n\n![build](https://github.com/shenxianpeng/year-progress/workflows/build/badge.svg) ![Profile views](https://gpvc.arturio.dev/shenxianpeng)")
    f.close()
