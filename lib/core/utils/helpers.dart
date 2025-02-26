String formatDuration(int totalSeconds) {
  final int hours = totalSeconds ~/ 3600;
  final int minutes = (totalSeconds % 3600) ~/ 60;
  final int seconds = totalSeconds % 60;

  if (hours > 0) {
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} hr';
  } else if (minutes > 0) {
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} min';
  } else {
    return '${seconds.toString().padLeft(2, '0')} sec';
  }
}
