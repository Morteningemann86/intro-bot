from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta

class date_utils:

    def last_day_of_month_relative_to_today(self, num_month_relative_today: int) -> datetime.date:
        """
        Returns the last day of a month relative to the current month. 
        For example, if the current month is March and num_month_relative_today is -1, 
        it will return the last day of February. If num_month_relative_today is 1, 
        it will return the last day of April.
        
        :param num_month_relative_today: The number of months relative to the current month.
        :return: The last day of the target month.
        """
        # Get the current date
        current_date = datetime.now()

        # Adjust the month based on the input
        target_month = current_date + relativedelta(months=num_month_relative_today)

        # Calculate the last day of that month
        last_day = target_month.replace(day=1) - timedelta(days=1)

        return last_day.date()

    def first_day_of_month_relative_to_today(self, num_month_relative_today: int) -> datetime.date:
        """
        Returns the first day of a month relative to the current month. 
        For example, if the current month is March and num_month_relative_today is -1, 
        it will return the first day of February. If num_month_relative_today is 1, 
        it will return the first day of April.
        
        :param num_month_relative_today: The number of months relative to the current month.
        :return: The first day of the target month.
        """
        # Get the current date
        current_date = datetime.now()

        # Adjust the month based on the input
        target_month = current_date + relativedelta(months=num_month_relative_today)

        # Set to the first day of that month
        first_day = target_month.replace(day=1)

        return first_day.date()