@EndUserText.label: 'PDF Output for Picklist'
define abstract entity ZSD_PICK_A_PDF_OUT
{
  PdfFile  : abap.string;
  FileName : abap.char(255);
  MimeType : abap.char(100);
}
