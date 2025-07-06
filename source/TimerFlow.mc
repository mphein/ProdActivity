
module TimerFlow {
    var timers = [
        { "title1" => "Focus", "headline" => "Stay on task. You've got this.", "subtext" => "", "phase" => DurationType.FOCUS},
        { "title1" => "Active", "headline" => "Get that heart rate up!", "subtext" => "We recommend stretching and a short walk.", "phase" => DurationType.ACTIVE},
        { "title1" => "Rest", "headline" => "Take it easy. You did great!", "subtext" => "Let your body recover — rest is part of progress.", "phase" => DurationType.FOCUS},
    ];

    function findPhaseIndex(phase) {
        for (var i = 0; i < timers.size(); i++) {
            if (timers[i]["phase"] == phase) {
                return i;
            }
        }
        return -1;
    }
}