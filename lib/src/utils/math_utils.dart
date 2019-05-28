
import "package:vector_math/vector_math_64.dart";

/**
 * Maps a value from a range, determined by old minimum and maximum values, to a new range,
 * determined by new minimum and maximum values. These minimum and maximum values are
 * referential; the new value is not clamped by them.
 *
 * @param value	The value to be re-mapped.
 * @param fromMin	The previous minimum value.
 * @param fromMax	The previous maximum value.
 * @param toMin	The new minimum value.
 * @param toMax	The new maximum value.
 * @return			The new value, mapped to the new range.
 */
double map(double value, double fromMin, double fromMax, [double toMin = 0.0, double toMax = 1.0, bool shouldClamp = false]) {
  if (fromMin == fromMax) return toMin;
	double p = ((value - fromMin) / (fromMax - fromMin) * (toMax - toMin)) + toMin;
	if (shouldClamp) p = fromMin < fromMax ? clamp(p, toMin, toMax) : clamp(p, toMax, toMin);
	return p;
}

/**
 * Clamps a number to a range, by restricting it to a minimum and maximum values: if the passed
 * value is lower than the minimum value, it's replaced by the minimum; if it's higher than the
 * maximum value, it's replaced by the maximum; if neither, it's unchanged.
 *
 * @param value	The value to be clamped.
 * @param min		Minimum value allowed.
 * @param max		Maximum value allowed.
 * @return			The newly clamped value.
 */
double clamp(double value, [double min = 0, double max = 1]) {
	return value < min ? min : value > max ? max : value;
}
