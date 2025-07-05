import DurationType;

module SessionFlow {
    var steps = [
        { "title1" => "Set your", "title2" => "total session length:", "phase" => DurationType.TOTAL },
        { "title1" => "Set your", "title2" => "active session length:", "phase" => DurationType.ACTIVE },
        { "title1" => "Set your", "title2" => "rest time:", "phase" => DurationType.REST }
    ];

    function findPhaseIndex(phase) {
        for (var i = 0; i < steps.size(); i++) {
            if (steps[i]["phase"] == phase) {
                return i;
            }
        }
        return -1;
    }
}   