// import logo from './logo.svg';
import './App.css';
import { FaFileAlt, FaCheck } from 'react-icons/fa';
import { useRef, useState } from 'react';
import { InfinitySpin } from  'react-loader-spinner'
import axios from 'axios';

function App() {
  const [files, setFiles] = useState([]);
  const [uploadedFiles, setUploadedFiles] = useState([]);
  const [apiResponse, setApiResponse] = useState("");
  const [showProgress, setShowProgress] = useState(false);
  const [isProcessing, setIsProcessing] = useState(false);
  const fileInputRef = useRef(null);

  const handleFileInputClick = () => {
    if (isProcessing === false) fileInputRef.current.click();
  }

  const uploadFile = (event) => {
    const MIN_FILE_SIZE = 0 // 0kb
    const MAX_FILE_SIZE = 5120 // 5MB
    const file = event.target.files[0];
    const allowedTypes = ["audio/mpeg"];

    if (!file) return;
    if (!allowedTypes.includes(file?.type)) {
      setApiResponse({text: ' ❌❌❌ Only MP3 audio are allowed. 😵‍💫😵‍💫😵‍💫'});
      return;
    }
    
    const fileSizeKiloBytes = file.size / 1024
    if(fileSizeKiloBytes < MIN_FILE_SIZE){
      setApiResponse({text: ' ❌❌❌ File size is less than minimum limit. 😮‍💨😮‍💨😮‍💨'});
      return
    }
    if(fileSizeKiloBytes > MAX_FILE_SIZE){
      setApiResponse({text: ' ❌❌❌ File size is greater than maximum limit. 😮‍💨😮‍💨😮‍💨'});
      return
    }
  
    const fileName = file.name.length > 12
    ? `${file.name.substring(0, 13)}... .${file.name.split('.')[1]}`
    : file.name;
    const formData = new FormData();
    formData.append('file', file);
    setFiles(prevState => [...prevState, {name: fileName, loading: 0}]);
    setShowProgress(true);
    setIsProcessing(true);
    axios.post('https://api-whisper.markpage2k1.dev/upload', formData, {
      onUploadProgress: ({loaded, total}) => {
        setFiles(prevState => {
          const newFiles = [...prevState];
          newFiles[newFiles.length - 1].loading = Math.floor((loaded / total) * 100);
          return newFiles;
        })
        if (loaded === total){
          const fileSize = total < 1024
          ? `${total}kb`
          : `${(loaded / (1020*1024)).toFixed(2)}Mb`;
          setUploadedFiles([...uploadedFiles, {name:fileName, size: fileSize}]);
          setFiles([]);
          setShowProgress(false);
        }
      },
    })
    .then(response => {
      setApiResponse(response.data);
      setIsProcessing(false);
      // console.log(response.data)
      // console.log(response.data);
    })
    .catch( response => {
      setApiResponse({text: 'The server encountered an error and cannot process the current file. Please try again with a different file.'});
      setIsProcessing(false);
    });
  }
  return (
    <div className='master'>
      <div className="upload-box">
        <p>Upload your file</p>
        <form onClick={handleFileInputClick}>
          <input className='file-input' type='file' name='file' accept='audio/mpeg' hidden ref={fileInputRef} onChange={uploadFile}/>
          <div className='icon'>
            <img src='/images/icons/upload.svg' alt=""/>
          </div>
          <p>Browse File to upload</p>
          <p className='file-size'>(Min size: 0Mb / Max size: 5Mb)</p>
        </form>
        {showProgress &&(
          <section className='loading-area'>
          {files.map((file, index) => (
            <li className='row' key={index}>
              <i><FaFileAlt /></i>
              <div className='content'>
                <div className='details'>
                  <span className='name'>
                    {`${file.name} - uploading`}
                  </span>
                  <span className='percent'>
                  {`${file.loading}%`}
                  </span>
                  <div className='loading-bar'>
                    <div className='loading' style={{width: `${file.loading}%`}}>
                    </div>
                  </div>
                </div>
              </div>
            </li>
          ))}
          </section>
        )}

        <section className='uploaded-area'>
          {uploadedFiles.map((file, index) => (
            <li className='row' key={index}>
              <div className='content upload'>
                <i><FaFileAlt /></i>
                <div className='details'>
                  <span className='name'>{file.name}</span>
                  <span className='size'>{file.size}</span>
                </div>
              </div>
              <i className='fa-check'><FaCheck /></i>
            </li>
          ))}
        </section>
      </div>
      <div className='respone-box'>
        <h2>👉API Response👈</h2>
        {isProcessing ? (
          <div>
            {!showProgress && (
              <div className='waiting-response'>
                <InfinitySpin
                  width='200'
                  color="#f39e54"
                />
                <p>Waiting for API response...</p>
              </div>
            )}
          </div>
        ):(
          <div>
            {apiResponse && (
              <p>{apiResponse.text}</p>
            )}
          </div>
        )}
      </div>
    </div>

  );
}

export default App;