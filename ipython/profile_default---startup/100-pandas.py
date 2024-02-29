try:
    import pandas
    pandas.set_option('display.max_columns', None)
    del pandas
except:
    pass
