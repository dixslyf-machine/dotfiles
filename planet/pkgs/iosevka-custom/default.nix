{ iosevka
, spacing ? "normal"
, ...
}:
let
  names =
    if spacing == "normal"
    then [ "custom" "Custom" ]
    else if spacing == "term"
    then [ "term-custom" "Term Custom" ]
    else throw "Unsupported spacing";
  set = builtins.head names;
  set-family = builtins.elemAt names 1;
in
iosevka.override {
  inherit set;
  privateBuildPlan = ''
    [buildPlans.iosevka-${set}]
    family = "Iosevka ${set-family}"
    spacing = "${spacing}"
    serifs = "sans"
    no-cv-ss = true
    export-glyph-names = true

      [buildPlans.iosevka-${set}.variants]
      inherits = "ss05"

        [buildPlans.iosevka-${set}.variants.design]
        capital-d = "standard-serifless"
        capital-k = "straight-serifless"
        capital-q = "detached-bend-tailed"
        f = "tailed"
        q = "earless-rounded-diagonal-tailed-serifless"
        long-s = "flat-hook-tailed"
        capital-gamma = "serifless"
        zero = "dotted"
        number-sign = "slanted-open"
        ampersand = "upper-open"
        at = "compact"
        dollar = "interrupted-cap"
        percent = "dots"
        bar = "natural-slope"
        lig-neq = "more-slanted"
        lig-equal-chain = "without-notch"
        lig-hyphen-chain = "with-notch"
        lig-double-arrow-bar = "without-notch"
        lig-single-arrow-bar = "without-notch"

      [buildPlans.iosevka-${set}.ligations]
      inherits = "dlig"
      enables = ["connected-number-sign"]
      disables = [
        "connected-tilde-as-wave",
        "connected-underscore",
        "connected-hyphen"
      ]
  '';
}
