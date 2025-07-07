
module TimerFlow {
    var timers = [
        { "title" => "Focus", "headline" => "Lock in.", "phase" => DurationType.FOCUS},
        { "title" => "Active", "headline" => "Get that heart rate up!", "phase" => DurationType.ACTIVE},
        { "title" => "Rest", "headline" => "Take it easy.", "phase" => DurationType.REST},
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