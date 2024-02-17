function cmd_vector = CreateCmd(timeseries_flag, timeseries_cmd, flag_num)
index = timeseries_cmd.Data==flag_num;
cmd_vector = timeseries(timeseries_flag.Data(index),timeseries_flag.Time(index));

cmd_vector.DataInfo.Interpolation = tsdata.interpolation('zoh');
end