String duzenle(String tumMetin, String silinecekMetin, {String bitis = ""}) {
  int varmi = tumMetin.indexOf(silinecekMetin);

  if (varmi == -1) {
    return tumMetin;
  } else if (bitis != "") {
    String altString1 = tumMetin.substring(varmi, tumMetin.length);
    int varmi2 = altString1.indexOf(bitis);
    if (varmi2 != -1) {
      altString1 = altString1.substring(0, altString1.indexOf(bitis) + 1);
      return tumMetin.replaceAll(altString1, "");
    }
  }

  return tumMetin.replaceAll(
      tumMetin.substring(tumMetin.indexOf(silinecekMetin), tumMetin.length),
      "");
}