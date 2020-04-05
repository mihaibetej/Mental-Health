import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';

const app = express();

app.use(bodyParser.json());
app.use(cors());

app.get('/',(req,res) => {
  res.send("Hello Firebase admin api")
})

app.listen(4000,() => {
  console.log(`4MedicAll is listening to port 4000`);
})