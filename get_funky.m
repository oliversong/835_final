function [funky_data] = get_funky(scratch_data)
    filtered = filter_data(scratch_data);
    formatted = format_data(filtered);
    funky_data = envelope(formatted);
end