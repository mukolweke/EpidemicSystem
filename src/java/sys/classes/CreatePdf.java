package sys.classes;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class CreatePdf {

    private static DB_class db = new DB_class();

    public static Document createPDF(String file, String data) throws Exception {

        Document document = null;

        try {
            document = new Document();
            PdfWriter.getInstance(document, new FileOutputStream(file));
            document.open();

            addMetaData(document, data);

            addTitlePage(document, data);

            createTable(document, data);

            document.close();

        } catch (FileNotFoundException e) {

            e.printStackTrace();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        return document;

    }

    private static void addMetaData(Document document, String data) {
        if (data.equals("Experts Report")) {
            document.addTitle("Generate Expert report");
            document.addSubject("Generate Expert report");
            document.addAuthor("FEWS APPLICATION ADMIN");
            document.addCreator("FEWS APPLICATION ADMIN");
        }
    }

    private static void addTitlePage(Document document, String data)
            throws DocumentException {
        if (data.equals("Experts Report")) {
            Paragraph preface = new Paragraph();
            creteEmptyLine(preface, 1);
            preface.add(new Paragraph("FEWS Expert Report"));

            creteEmptyLine(preface, 1);
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM/dd/yyyy");
            preface.add(new Paragraph("Report created on "
                    + simpleDateFormat.format(new Date())));
            document.add(preface);

        }
    }

    private static void creteEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }

    private static void createTable(Document document, String data) throws DocumentException, Exception {
        if (data.equals("Experts Report")) {
            Paragraph paragraph = new Paragraph();
            creteEmptyLine(paragraph, 2);
            document.add(paragraph);
            PdfPTable table = new PdfPTable(6);

            PdfPCell c1 = new PdfPCell(new Phrase("Full Name"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(c1);

            c1 = new PdfPCell(new Phrase("Email"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(c1);

            c1 = new PdfPCell(new Phrase("Phone"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(c1);

            c1 = new PdfPCell(new Phrase("Expert Field"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(c1);

            c1 = new PdfPCell(new Phrase("Location"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(c1);

            c1 = new PdfPCell(new Phrase("Registration Date"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(c1);
            table.setHeaderRows(1);

            for (int i = 0; i < db.countFarmer(); i++) {
                table.setWidthPercentage(100);
                table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
                table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
                table.addCell("1");
                table.addCell("2");
                table.addCell("3");
                table.addCell("4");
                table.addCell("5");
                table.addCell("6");
            }

            document.add(table);
        }
    }
}
