import Toybox.Lang;
//! SessionFlow manages the order and display information
//! for the duration selection views in the setup flow.
//! The `steps` array defines each configuration screen,
//! and `findPhaseIndex()` is used to determine the current position
//! based on a DurationType phase.
module SessionFlow {
    var steps as Array<Dictionary> = [
        { "title1" => "Set your", "title2" => "focus duration:", "phase" => DurationType.FOCUS },
        { "title1" => "Set your", "title2" => "active session length:", "phase" => DurationType.ACTIVE},
        { "title1" => "Set your", "title2" => "rest time:", "phase" => DurationType.REST },
        { "title1" => "Set your", "title2" => "intervals:", "phase" => DurationType.INTERVALS}
    ];

    // Finds the index of the step corresponding to the given phase.
    // @param phase The DurationType phase to find
    // @return The index in the steps array, or -1 if not found
    function findPhaseIndex(phase as String) {
        for (var i = 0; i < steps.size(); i++) {
            if (steps[i]["phase"] == phase) {
                return i;
            }
        }
        return -1;
    }
    
    // @return Number of steps in the session flow.
    function count() as Number {
        return steps.size();
    }
}   