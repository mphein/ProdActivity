import DurationType;
import Toybox.Lang;

//! DurationLimits defines the attributes of each timer phase,
//! including min/max values, increment steps, and display suffixes.
module DurationLimits {
    var limits as Dictionary = {
        (DurationType.ACTIVE) => {"min" => 0, "max" => 10, "incr"=>1, "str"=>" min"},
        (DurationType.REST)  => {"min" => 0, "max" => 10, "incr"=>1, "str"=>" min"},
        (DurationType.FOCUS) => {"min" => 20, "max" => 60, "incr"=>5, "str"=>" min"},
        (DurationType.INTERVALS) => {"min"=>1, "max"=> 4, "incr"=>1, "str"=>""}
    };
}