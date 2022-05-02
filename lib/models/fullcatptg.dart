import 'package:wm_workbench/models/pt.dart';

class Catptg {
  Map<String, Ptg> catptg;
  Catptg(this.catptg);
}

class Ptg {
  Map<String, List<PtDB>> ptg;
  Ptg(this.ptg);
}
