/**
 * 诗词类
 */
export class Poetry{
  id:string = '';
  type:number = 0;
  title:string = '';
  dynasty:string = '';
  author:string = '';
  poetryArr:string[] = [];
  appreciationArr:Appreciation[] = [];
  authorDetail:string = '';
  excerptArr:string[] = [];
  categoryArr:string[] = [];

  constructor(id:string, type:number, title:string, dynasty:string, author:string, poetryArr:string[], appreciationArr:Appreciation[], authorDetail:string, excerptArr:string[], categoryArr:string[]){
    this.id = id;
    this.type = type;
    this.title = title;
    this.dynasty = dynasty;
    this.author = author;
    this.poetryArr = poetryArr;
    this.appreciationArr = appreciationArr;
    this.authorDetail = authorDetail;
    this.excerptArr = excerptArr;
    this.categoryArr = categoryArr;
  }
}

/**
 * 赏析类
 */
export class Appreciation{
  comments:string = '';   // 点评
  publishInfo:string = '';// 出版信息

  constructor(comments:string, publishInfo:string){
    this.comments = comments;
    this.publishInfo = publishInfo;
  }
}

export class AuthorDetail{
  years:string = '';
  info:string = '';
}