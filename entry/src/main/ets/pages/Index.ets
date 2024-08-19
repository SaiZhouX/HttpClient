import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { Poetry } from '../model/Poetry';

@Entry
@Component
struct Index {
  @State showPoetrys: Poetry[] = [];

  build() {
    Column(){
      Button("request").onClick(() => {
        this.showPoetrys = RequestInfo();
      })

      List(){
        ForEach(this.showPoetrys, (item: Poetry) => {
          ListItem() {
            Text(item.id + "," + item.title)
          }
        }, (item: Poetry) => item.id)
      }
    }
  }
}

const poetrys: Poetry[] = [];
const regex: RegExp = /{[^{}]*}/g;

function RequestInfo(): Poetry[] {
  let url: string = "http://192.168.0.27:8001/test";
  // let url:string = "https://oauth-login.cloud.huawei.com/oauth2/v3/token"
  // 每一个httpRequest对应一个HTTP请求任务，不可复用
  let httpRequest = http.createHttp();
  httpRequest.request(url, {
    method: http.RequestMethod.POST,
    extraData: { "id": "1" }
    // extraData:{"grant_type":"authorization_code","code":"EAEEACvgnfeubiRXVk6gviH2Iryh7Z82XNTMxkllOgW9vCmULrXvb9PsXpb5AvrU1nv9janDJx2aAaBQtEtEOCkb/4S3t3zOvAnVoS7r9LPATde4phgsBcqYn2AWGfpfMJwEIXg9bs6HiBQ1ddTerm7c00EPxxrwglICq63SqSTmzGK/5y64MVtcjktDCyjhmrJhQ1dHj1OwXnFl+tyyT4Sb33DXErnFctCr79KB5RrcDc0oCHlaO+nSUooAF3OfqDr4gV5OkSqCtnaTFQ==","client_id":"111302091","client_secret":"ea62753cc78353aac1fa3d5d0c836b78d84fade4ed4686bd113514876d9059a9"}
  }, (err: BusinessError, data: http.HttpResponse) => {
    if (!err) {
      // data.result为HTTP响应内容，可根据业务需要进行解析
      console.info('Result:' + JSON.stringify(data.result));
      console.info('code:' + JSON.stringify(data.responseCode));
      // data.header为HTTP响应头，可根据业务需要进行解析
      console.info('header:' + JSON.stringify(data.header));
      console.info('cookies:' + JSON.stringify(data.cookies)); // 8+
      parseResult(data.result as string, regex, poetrys);
      // 当该请求使用完毕时，调用destroy方法主动销毁
      httpRequest.destroy();
    } else {
      console.error('error:' + JSON.stringify(err));
      // 取消订阅HTTP响应头事件
      httpRequest.off('headersReceive');
      // 当该请求使用完毕时，调用destroy方法主动销毁
      httpRequest.destroy();
    }
  })

  return poetrys;
}

function parseResult(result: string, regex: RegExp, poetrys: Poetry[]) {
  // const PoetryObj = JSON.parse(result) as Poetry;
  // @State poetrys:Poetry[] = [];
  // const  regex:RegExp = /{[^{}]*}/g;
  const matches = result.match(regex);

  if (matches) {
    matches.forEach((match: string) => {
      const poetryObj = JSON.parse(match) as Poetry;
      poetrys.push(poetryObj);
    });
  }
}
