export interface ItemProps {
  _id?: string;             
  title: string;            
  author: string; 
  liked: boolean; 
  releaseDate: string;               
  children?: React.ReactNode;                    
}
