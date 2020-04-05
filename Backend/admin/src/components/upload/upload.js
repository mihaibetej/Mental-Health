import React, { useState } from 'react';
import { Upload, Button,message,Form  } from 'antd';
import { UploadOutlined } from '@ant-design/icons';

const UploadImage =()=> {
    const [fileList , setFileList] = useState([]);

  const handleChange = (info) => {
    let fileList = [...info.fileList];
    fileList = fileList.slice(-1);
    setFileList(fileList);
  };

   const handleBeforeUpload=(file) =>{
    
    return false;
  }

    return (
      <Form.Item name="image" label="Image">
        <Upload
          accept={"image/x-png,image/jpeg" }
          multiple={false} 
          onChange={handleChange}
          beforeUpload={handleBeforeUpload}
          fileList={fileList}
        >
          <Button>
            <UploadOutlined />
            Incarca
          </Button>
        </Upload>
      </Form.Item>
    );
  
}

export default UploadImage;