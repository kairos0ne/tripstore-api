module TimeHelper
    def strip_dates(parkings)
        while parkings.ArrivalTime.present?
            read_attribute(:ArrivalTime).strftime("%H:%M:%S")
        end
    end
  end