import hy
from trytond.pool import Pool
from . import hello


def register():
    Pool.register(
        hello.HelloSummaryView,
        module='hello_summary_view', type_='model')
