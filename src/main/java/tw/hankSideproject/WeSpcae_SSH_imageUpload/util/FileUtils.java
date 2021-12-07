package tw.hankSideproject.WeSpcae_SSH_imageUpload.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

public class FileUtils {

    /**
     * @param file     文件
     * @param path     文件存放路径
     * @param fileName 保存的文件名
     * @return
     */
    public static boolean upload(MultipartFile file, String path, String fileName) {

        //確定上傳的文件名
        String realPath = path + "/" + fileName;
        System.out.println("上傳文件：" + realPath);

        File dest = new File(realPath);

        //判斷文件父目錄是否存在
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdir();
        }

        try {
            //保存文件
            file.transferTo(dest);
            return true;
        } catch (IllegalStateException e) {
        	System.out.println("進來IllegalStateException");
            e.printStackTrace();
            return false;
        } catch (IOException e) {
        	System.out.println("進來IOException");
            e.printStackTrace();
            return false;
        }

    }

}

