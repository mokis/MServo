def curve_interpolation_lim(curve_x, curve_y, input_val, array_len):
    last = array_len - 1
    i = 0

    ratio = 0
    dy = 0
    output_val = 0

    if input_val <= curve_x[0]:
        return curve_y[0]

    if input_val >= curve_x[last]:
        return curve_y[last]
   
    while curve_x[i] < input_val:
        i = i + 1

    ratio = float(input_val - curve_x[i-1]) / (curve_x[i] - curve_x[i-1])
    print "r", ratio

    dy = curve_y[i] - curve_y[i-1]
    print "dy"
    output_val = curve_y[i-1] + ratio * dy

    return output_val


curve_x = [-10.0, 0.0, 10.0]
curve_y = [11.0,10.0,0.0]

i = -5.0

#for i in range(-15,25,10):
res = curve_interpolation_lim(curve_x, curve_y, float(i), 3)
print i, res

