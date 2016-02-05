#!/Applications/Mathematica.app/Contents/MacOS/MathematicaScript -script
(* << functions` *)
(* dir1 = SetDirectory[NotebookDirectory[]]; *)
dir1 = "."

exp = "t2kk";
L = "1000";
OAB1 = "3.0";
OAB2 = "0.5";
MH = "1";
th23 = "0.5";
rnu = "3";
ranu = "7";

dir = dir1 <> "/rslt_" <> exp <> "_" <> OAB1 <> "_CP_nh_50MeV_40pt_test";

file = dir <> "/CP_true_" <> exp <> "_" <> L <> "_" <> OAB1 <> 
"_" <>  OAB2 <> "_" <> MH <> "_" <> rnu <> "_" <> ranu <> "_" <> th23 <> 
  "/CP_input-CP_test_NAN_NAN";

data = Import[file <> ".dat"];

dataout = {};
Do[
  If[data[[i]] == {}, AppendTo[dataout, {}];,
    AA = data[[i, 2]] - data[[i, 1]];
    If[AA > 180, AA = -(360 - AA)];
    If[AA < -180, AA = 360 + AA];
    AppendTo[dataout, {data[[i, 1]], AA, data[[i, 3]]}]];
  , {i, Length[data]}];
Export[file <> "_mod.dat", dataout];
