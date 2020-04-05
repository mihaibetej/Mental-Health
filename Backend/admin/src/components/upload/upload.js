import React, { useState } from 'react';
import { Upload, Button, Form } from 'antd';
import { UploadOutlined } from '@ant-design/icons';

const UploadImage =(defaultImage)=> {
  const defaultFileList= defaultImage.defaultImage?[
    {
      uid: '1',
      name: 'image',
      status: 'done',
      url: defaultImage.defaultImage,
    }]:[];

  const [fileList , setFileList] = useState(defaultFileList);

  const handleChange = (info) => {
    let imageList = [...info.fileList];
    imageList = imageList.slice(-1);
    setFileList(imageList);
  };

    return (
      <Form.Item name="image" label="Image">
        <Upload
          defaultFileList
          listType="picture-card"
          accept="image/x-png,image/jpeg"
          multiple={false} 
          onChange={handleChange}
          beforeUpload={()=>false}
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