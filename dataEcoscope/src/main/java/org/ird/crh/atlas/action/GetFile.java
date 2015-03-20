package org.ird.crh.atlas.action;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;

import org.ird.crh.ecoscope.kb.pojos.ResourcesLocation;
import org.ird.crh.ecoscope.libraries.ConstantsKeeper;

import com.opensymphony.xwork2.ActionSupport;

/**
 * Cette classe Action délivre des fichiers sous forme de flux binaires aux
 * vues. Les chemins vers les fichiers doivent être fournis via le setter
 * setFilePath en respectant les principes suivants :
 * <ul>
 * <li>Fournir le chemin relatif + nom du fichier à rechercher, généralement
 * (mais pas nécessairement) obtenu depuis le triplet RDF d'une ressource. Ce
 * chemin relatif sera concaténé avec un des préfixes de chemin absolu contenus
 * dans la liste <files_locations> du fichier de configuration général, pour
 * donner un chemin absolu.</li>
 * <li>Pour ce faire ce chemin relatif doit correspondre avec l'une des
 * expressions régulières <files_location/regex> de la liste <files_location>.
 * Lorsqu'une correspondance est trouvée entre le chemin relatif et une des
 * expressions <files_location/regex> correspondantes, le chemin relatif est
 * transformé en chemin absolu.</li>
 * </ul>
 * Ce mécanisme permet de charger des fichiers éventuellement stockés sur des
 * systèmes de fichier différents.
 *
 * Cette classe gère différemment deux types de fichiers :
 * <ul>
 * <li>Fourniture de fichiers autres que des images</li>
 * <li>Fourniture de fichiers images : dans ce cas le fichier peut être délivré
 * dans sa taille originale ou dans une taille inférieure (avec conservation du
 * ratio d'aspect). La demande de taille spécifique se fait via le setter
 * setPicSize. Si le fichier existe dans la taille demandée il sera simplement
 * retourné. S'il n'existe pas encore il sera créé, stocké pour les utilisations
 * futures, puis retourné</li>
 * </ul>
 *
 * @author pcauquil
 */
public class GetFile extends ActionSupport {

    /**
     * Chemin relatif + nom du fichier à rechercher. Voir le setter
     * correspondant pour les détails.
     */
    private String filePath = null;
    /**
     * Taille de l'image demandée, sous la forme YYYxZZZ, où YYY est le nombre
     * de pixels sur l'axe des abscisses et ZZZ sur l'axe des ordonnées. Exemple
     * : 800x600
     */
    private String picSize = null;
    private Boolean download = true;

    private static final long serialVersionUID = 8703719832834866931L;
    /**
     * Tableau d'octets destiné à stocker temporairement le fichier avant de le
     * renvoyer sous forme de flux binaire
     */
    private byte[] bytesData = null;
    /**
     * Propriété d'accès aux paramètres de configuration de l'application
     * (ecoscopekb-config.xml)
     */
    private ConstantsKeeper ck = ConstantsKeeper.getInstance();
    FileInputStream in;
    File f;
    int scaledWidth;
    int scaledHeight;

    /**
     * Méthode exécutée par le S² Result
     * org.ird.crh.ecoscope.kb.strutsresults.BytesResult pour obtenir le
     * fichier.
     *
     * @return Le fichier demandé sous forme d'un byte[]
     * @throws Exception
     */
    public byte[] getDocumentInBytes() throws Exception {
        String fullOriginalPath = null;
        String fullResizedPath = null;

        /**
         * Constitution du chemin absolu par correspondance du chemin relatif
         * avec les expressions régulières <files_locations/regex> du fichier de
         * configuration général
         *
         */
        for (int i = 0; i < ck.RESOURCES_FILES_LOCATIONS.size(); i++) {
            ResourcesLocation resLoc = ck.RESOURCES_FILES_LOCATIONS.get(i);

            if (filePath.matches(resLoc.getRegex())) {
                /**
                 * Recherche physique du fichier à partir du chemin constitué
                 *
                 */
                fullOriginalPath = resLoc.getBasePath() + filePath;

                /**
                 * Si c'est une image, détermination de la taille demandée
                 */
                fullResizedPath = this.getResizedPicturePath(resLoc, filePath, picSize);
                if (ck.DEBUG) {
                    System.err.println("GetFile.getDocumentInBytes(): path of the resized picture: " + fullResizedPath);
                }

                f = new File(fullResizedPath);
                // File was found
                if (f.canRead()) {
                    return this.getDocument();
                } // File wasn't found
                else {
                    // If it'a a picture
                    if (picSize != null && !fullResizedPath.equals(fullOriginalPath)) {
						// Picture with this size wasn't found. Generating the resized version

                        // Retrieving the original file
                        f = new File(fullOriginalPath);
                        if (ck.DEBUG) {
                            System.err.println("GetFile.getDocumentInBytes(): path of the original picture: " + fullOriginalPath);
                        }

                        if (f.canRead()) {
                            BufferedImage bi = ImageIO.read(f);
                            BufferedImage scaledBI = this.getNewImage(bi, Integer.valueOf(picSize.split("x")[0]), Integer.valueOf(picSize.split("x")[1]));
                            boolean fileWritten = this.writeImageFile(scaledBI, fullResizedPath, ck.JPG_QUALITY);

                            // Now loading the file from the FS
                            if (fileWritten) {
                                f = new File(fullResizedPath);
                                if (f.canRead()) {
                                    return this.getDocument();
                                } else {
                                    System.err.println("GetFile.getDocumentInBytes(): the resized version of the picture wasn't found on the file system.");
                                    System.err.println("Read the original version to resize it. The file was resized and written on the file system.");
                                    System.err.println("However, this new and resized file wasn't readable.");
                                    System.err.println("Path of the resized version was: " + fullResizedPath);
                                    System.err.println("Path of the original version was: " + fullOriginalPath);
                                    return null;
                                }
                            } else {
                                System.err.println("GetFile.getDocumentInBytes(): the resized version of the picture wasn't found on the file system.");
                                System.err.println("Read the original version to resize it. The file was resized and written on the file system.");
                                System.err.println("However, the resizing process failed. The new file wasn't written on the file system.");
                                System.err.println("Path of the resized version was: " + fullResizedPath);
                                System.err.println("Path of the original version was: " + fullOriginalPath);
                                return null;
                            }
                        } else {
                            System.err.println("GetFile.getDocumentInBytes(): the resized version of the picture wasn't found on the file system.");
                            System.err.println("Tried to read the original version to resize it, but original file wasn't found too");
                            System.err.println("Path of the resized version was: " + fullResizedPath);
                            return null;
                        }
                    } else {
                        System.err.println("GetFile.getDocumentInBytes(): the file wasn't found on the file system.");
                    }
                }
                break;
            }
        }

        return null;
    }

    // Private methods
    private String getResizedPicturePath(ResourcesLocation rl, String filePath, String picSize) {
        String fullPath = null;
		//String replacementString = null;

        // Checking if the requested file is anything else than a picture or if the picture is requested in the original resolution
        if (picSize == null || picSize.equalsIgnoreCase(rl.getOriginalSizeRequestKeyword())) {
            fullPath = rl.getBasePath() + filePath;
        } // Else customizing the path for the requested resolution
        else if (filePath.contains(rl.getSizeSpecificString())) {
            fullPath = rl.getBasePath() + filePath.replace(rl.getSizeSpecificString(), "/" + picSize + "/");
        }
        return fullPath;
    }

    private byte[] getDocument() {
        if (f.canRead()) {
            bytesData = new byte[(int) f.length()];	// Could this cast be a limitation (cause int range limitation)
            try {
                in = new FileInputStream(f);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
            try {
                in.read(bytesData);
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            return bytesData;
        } else {
            return null;
        }
    }

    private BufferedImage getNewImage(BufferedImage bi, Integer requiredWidth, Integer requiredHeight) {
        float rX = (float) requiredWidth / (float) bi.getWidth();
        float rY = (float) requiredHeight / (float) bi.getHeight();

        if (rX < rY) {
            scaledWidth = requiredWidth;
            scaledHeight = Math.round(bi.getHeight() * rX);
        } else {
            scaledWidth = Math.round(bi.getWidth() * rY);
            scaledHeight = requiredHeight;
        }

        BufferedImage scaledBI = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = scaledBI.createGraphics();
        g.setComposite(AlphaComposite.Src);
        g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        g.drawImage(bi, 0, 0, scaledWidth, scaledHeight, null);
        g.dispose();

        return scaledBI;
    }

    boolean writeImageFile(BufferedImage newBI, String path, float quality) {
        OutputStream out = null;
        try {
            out = new FileOutputStream(path);
            // TODO Create subdirectories if they don't exist
        } catch (FileNotFoundException e) {
            // Creating the required directories
            String pathWithoutFileName = path.substring(0, path.lastIndexOf(File.separator));
            File fb = new File(pathWithoutFileName);
            if (fb.mkdirs()) {
                try {
                    out = new FileOutputStream(path);
                } catch (FileNotFoundException e1) {
                    e1.printStackTrace();
                    return false;
                }
            } else {
                return false;
            }
        }

        try {
            if (path.endsWith("png") || path.endsWith("PNG")) {
                ImageIO.write(newBI, "png", out);
            } else if (path.endsWith("gif") || path.endsWith("GIF")) {
                ImageIO.write(newBI, "gif", out);
            } else if (path.endsWith("bmp") || path.endsWith("BMP")) {
                ImageIO.write(newBI, "bmp", out);
            } else {
                // Encoding JPG and unknown formats as JPG
                /*JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
                 JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(newBI);
                 param.setQuality(quality, false);
                 encoder.setJPEGEncodeParam(param);
		        
                 encoder.encode(newBI);*/
                ImageIO.write(newBI, "jpg", out);
            }
            out.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return false;
        }

        return true;
    }

    // Getters & setters
    public void setFilePath(String filePath) {
        if (!filePath.startsWith(File.separator)) {
            this.filePath = File.separator + filePath;
        } else {
            this.filePath = filePath;
        }
    }

    public void setPicSize(String picSize) {
        this.picSize = picSize;
    }

    public String getFileName() {
        String fileName;
        int separatorLoc = filePath.lastIndexOf(File.separator);

        if (separatorLoc > -1) {
            fileName = filePath.substring(separatorLoc + 1);
        } else {
            fileName = filePath;
        }

        return fileName;
    }

    public void setDownload(Boolean download) {
        this.download = download;
    }

    public Boolean isDownload() {
        return download;
    }

}
