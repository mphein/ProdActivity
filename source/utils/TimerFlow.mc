import Toybox.Lang;

//! TimerFlow manages the order and display information
//! for the active timer views.
//! The `timers` array defines each configuration screen,
//! and `findPhaseIndex()` is used to determine the current position
//! based on a DurationType phase.
module TimerFlow {
    var timers as Array<Dictionary> = [
        { "title" => "Focus", "headline" => "Lock in.", "phase" => DurationType.FOCUS},
        { "title" => "Active", "headline" => "Get that heart rate up!", "phase" => DurationType.ACTIVE},
        { "title" => "Rest", "headline" => "Take it easy.", "phase" => DurationType.REST},
    ];

    // Finds the index of the timer corresponding to the given phase.
    // @param phase The DurationType phase to find
    // @return The index in the timer array, or -1 if not found
    function findPhaseIndex(phase) {
        for (var i = 0; i < timers.size(); i++) {
            if (timers[i]["phase"] == phase) {
                return i;
            }
        }
        return -1;
    }
}