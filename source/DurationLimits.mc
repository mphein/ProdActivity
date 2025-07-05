import DurationType;

module DurationLimits {
    var limits = {
        (DurationType.ACTIVE) => {"min" => 0, "max" => 5, "incr"=>1},
        (DurationType.REST)  => {"min" => 0, "max" => 5, "incr"=>1},
        (DurationType.TOTAL) => {"min" => 30, "max" => 120, "incr"=>30}
    };
}