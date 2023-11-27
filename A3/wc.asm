
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 24             	sub    $0x24,%esp
   7:	e8 de 01 00 00       	call   1ea <__x86.get_pc_thunk.bx>
   c:	81 c3 50 0d 00 00    	add    $0xd50,%ebx
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  12:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  19:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
  25:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2c:	eb 71                	jmp    9f <wc+0x9f>
    for(i=0; i<n; i++){
  2e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  35:	eb 60                	jmp    97 <wc+0x97>
      c++;
  37:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
  3b:	8d 93 24 00 00 00    	lea    0x24(%ebx),%edx
  41:	8b 45 f4             	mov    -0xc(%ebp),%eax
  44:	01 d0                	add    %edx,%eax
  46:	0f b6 00             	movzbl (%eax),%eax
  49:	3c 0a                	cmp    $0xa,%al
  4b:	75 04                	jne    51 <wc+0x51>
        l++;
  4d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  51:	8d 93 24 00 00 00    	lea    0x24(%ebx),%edx
  57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5a:	01 d0                	add    %edx,%eax
  5c:	0f b6 00             	movzbl (%eax),%eax
  5f:	0f be c0             	movsbl %al,%eax
  62:	83 ec 08             	sub    $0x8,%esp
  65:	50                   	push   %eax
  66:	8d 83 f6 fc ff ff    	lea    -0x30a(%ebx),%eax
  6c:	50                   	push   %eax
  6d:	e8 84 02 00 00       	call   2f6 <strchr>
  72:	83 c4 10             	add    $0x10,%esp
  75:	85 c0                	test   %eax,%eax
  77:	74 09                	je     82 <wc+0x82>
        inword = 0;
  79:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80:	eb 11                	jmp    93 <wc+0x93>
      else if(!inword){
  82:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  86:	75 0b                	jne    93 <wc+0x93>
        w++;
  88:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
  8c:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
  93:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  97:	8b 45 f4             	mov    -0xc(%ebp),%eax
  9a:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  9d:	7c 98                	jl     37 <wc+0x37>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  9f:	83 ec 04             	sub    $0x4,%esp
  a2:	68 00 02 00 00       	push   $0x200
  a7:	8d 83 24 00 00 00    	lea    0x24(%ebx),%eax
  ad:	50                   	push   %eax
  ae:	ff 75 08             	push   0x8(%ebp)
  b1:	e8 19 04 00 00       	call   4cf <read>
  b6:	83 c4 10             	add    $0x10,%esp
  b9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  bc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  c0:	0f 8f 68 ff ff ff    	jg     2e <wc+0x2e>
      }
    }
  }
  if(n < 0){
  c6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  ca:	79 19                	jns    e5 <wc+0xe5>
    printf(1, "wc: read error\n");
  cc:	83 ec 08             	sub    $0x8,%esp
  cf:	8d 83 fc fc ff ff    	lea    -0x304(%ebx),%eax
  d5:	50                   	push   %eax
  d6:	6a 01                	push   $0x1
  d8:	e8 76 05 00 00       	call   653 <printf>
  dd:	83 c4 10             	add    $0x10,%esp
    exit();
  e0:	e8 d2 03 00 00       	call   4b7 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  e5:	83 ec 08             	sub    $0x8,%esp
  e8:	ff 75 0c             	push   0xc(%ebp)
  eb:	ff 75 e8             	push   -0x18(%ebp)
  ee:	ff 75 ec             	push   -0x14(%ebp)
  f1:	ff 75 f0             	push   -0x10(%ebp)
  f4:	8d 83 0c fd ff ff    	lea    -0x2f4(%ebx),%eax
  fa:	50                   	push   %eax
  fb:	6a 01                	push   $0x1
  fd:	e8 51 05 00 00       	call   653 <printf>
 102:	83 c4 20             	add    $0x20,%esp
}
 105:	90                   	nop
 106:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 109:	c9                   	leave  
 10a:	c3                   	ret    

0000010b <main>:

int
main(int argc, char *argv[])
{
 10b:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 10f:	83 e4 f0             	and    $0xfffffff0,%esp
 112:	ff 71 fc             	push   -0x4(%ecx)
 115:	55                   	push   %ebp
 116:	89 e5                	mov    %esp,%ebp
 118:	56                   	push   %esi
 119:	53                   	push   %ebx
 11a:	51                   	push   %ecx
 11b:	83 ec 1c             	sub    $0x1c,%esp
 11e:	e8 c7 00 00 00       	call   1ea <__x86.get_pc_thunk.bx>
 123:	81 c3 39 0c 00 00    	add    $0xc39,%ebx
 129:	89 ce                	mov    %ecx,%esi
  int fd, i;

  if(argc <= 1){
 12b:	83 3e 01             	cmpl   $0x1,(%esi)
 12e:	7f 19                	jg     149 <main+0x3e>
    wc(0, "");
 130:	83 ec 08             	sub    $0x8,%esp
 133:	8d 83 19 fd ff ff    	lea    -0x2e7(%ebx),%eax
 139:	50                   	push   %eax
 13a:	6a 00                	push   $0x0
 13c:	e8 bf fe ff ff       	call   0 <wc>
 141:	83 c4 10             	add    $0x10,%esp
    exit();
 144:	e8 6e 03 00 00       	call   4b7 <exit>
  }

  for(i = 1; i < argc; i++){
 149:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
 150:	e9 85 00 00 00       	jmp    1da <main+0xcf>
    if((fd = open(argv[i], 0)) < 0){
 155:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 158:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 15f:	8b 46 04             	mov    0x4(%esi),%eax
 162:	01 d0                	add    %edx,%eax
 164:	8b 00                	mov    (%eax),%eax
 166:	83 ec 08             	sub    $0x8,%esp
 169:	6a 00                	push   $0x0
 16b:	50                   	push   %eax
 16c:	e8 86 03 00 00       	call   4f7 <open>
 171:	83 c4 10             	add    $0x10,%esp
 174:	89 45 e0             	mov    %eax,-0x20(%ebp)
 177:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
 17b:	79 2b                	jns    1a8 <main+0x9d>
      printf(1, "wc: cannot open %s\n", argv[i]);
 17d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 180:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 187:	8b 46 04             	mov    0x4(%esi),%eax
 18a:	01 d0                	add    %edx,%eax
 18c:	8b 00                	mov    (%eax),%eax
 18e:	83 ec 04             	sub    $0x4,%esp
 191:	50                   	push   %eax
 192:	8d 83 1a fd ff ff    	lea    -0x2e6(%ebx),%eax
 198:	50                   	push   %eax
 199:	6a 01                	push   $0x1
 19b:	e8 b3 04 00 00       	call   653 <printf>
 1a0:	83 c4 10             	add    $0x10,%esp
      exit();
 1a3:	e8 0f 03 00 00       	call   4b7 <exit>
    }
    wc(fd, argv[i]);
 1a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 1b2:	8b 46 04             	mov    0x4(%esi),%eax
 1b5:	01 d0                	add    %edx,%eax
 1b7:	8b 00                	mov    (%eax),%eax
 1b9:	83 ec 08             	sub    $0x8,%esp
 1bc:	50                   	push   %eax
 1bd:	ff 75 e0             	push   -0x20(%ebp)
 1c0:	e8 3b fe ff ff       	call   0 <wc>
 1c5:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1c8:	83 ec 0c             	sub    $0xc,%esp
 1cb:	ff 75 e0             	push   -0x20(%ebp)
 1ce:	e8 0c 03 00 00       	call   4df <close>
 1d3:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
 1d6:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 1da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1dd:	3b 06                	cmp    (%esi),%eax
 1df:	0f 8c 70 ff ff ff    	jl     155 <main+0x4a>
  }
  exit();
 1e5:	e8 cd 02 00 00       	call   4b7 <exit>

000001ea <__x86.get_pc_thunk.bx>:
 1ea:	8b 1c 24             	mov    (%esp),%ebx
 1ed:	c3                   	ret    

000001ee <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1ee:	55                   	push   %ebp
 1ef:	89 e5                	mov    %esp,%ebp
 1f1:	57                   	push   %edi
 1f2:	53                   	push   %ebx
 1f3:	e8 b3 02 00 00       	call   4ab <__x86.get_pc_thunk.ax>
 1f8:	05 64 0b 00 00       	add    $0xb64,%eax
  asm volatile("cld; rep stosb" :
 1fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
 200:	8b 55 10             	mov    0x10(%ebp),%edx
 203:	8b 45 0c             	mov    0xc(%ebp),%eax
 206:	89 cb                	mov    %ecx,%ebx
 208:	89 df                	mov    %ebx,%edi
 20a:	89 d1                	mov    %edx,%ecx
 20c:	fc                   	cld    
 20d:	f3 aa                	rep stos %al,%es:(%edi)
 20f:	89 ca                	mov    %ecx,%edx
 211:	89 fb                	mov    %edi,%ebx
 213:	89 5d 08             	mov    %ebx,0x8(%ebp)
 216:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 219:	90                   	nop
 21a:	5b                   	pop    %ebx
 21b:	5f                   	pop    %edi
 21c:	5d                   	pop    %ebp
 21d:	c3                   	ret    

0000021e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 21e:	55                   	push   %ebp
 21f:	89 e5                	mov    %esp,%ebp
 221:	83 ec 10             	sub    $0x10,%esp
 224:	e8 82 02 00 00       	call   4ab <__x86.get_pc_thunk.ax>
 229:	05 33 0b 00 00       	add    $0xb33,%eax
  char *os;

  os = s;
 22e:	8b 45 08             	mov    0x8(%ebp),%eax
 231:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 234:	90                   	nop
 235:	8b 55 0c             	mov    0xc(%ebp),%edx
 238:	8d 42 01             	lea    0x1(%edx),%eax
 23b:	89 45 0c             	mov    %eax,0xc(%ebp)
 23e:	8b 45 08             	mov    0x8(%ebp),%eax
 241:	8d 48 01             	lea    0x1(%eax),%ecx
 244:	89 4d 08             	mov    %ecx,0x8(%ebp)
 247:	0f b6 12             	movzbl (%edx),%edx
 24a:	88 10                	mov    %dl,(%eax)
 24c:	0f b6 00             	movzbl (%eax),%eax
 24f:	84 c0                	test   %al,%al
 251:	75 e2                	jne    235 <strcpy+0x17>
    ;
  return os;
 253:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 256:	c9                   	leave  
 257:	c3                   	ret    

00000258 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 258:	55                   	push   %ebp
 259:	89 e5                	mov    %esp,%ebp
 25b:	e8 4b 02 00 00       	call   4ab <__x86.get_pc_thunk.ax>
 260:	05 fc 0a 00 00       	add    $0xafc,%eax
  while(*p && *p == *q)
 265:	eb 08                	jmp    26f <strcmp+0x17>
    p++, q++;
 267:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 26b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 26f:	8b 45 08             	mov    0x8(%ebp),%eax
 272:	0f b6 00             	movzbl (%eax),%eax
 275:	84 c0                	test   %al,%al
 277:	74 10                	je     289 <strcmp+0x31>
 279:	8b 45 08             	mov    0x8(%ebp),%eax
 27c:	0f b6 10             	movzbl (%eax),%edx
 27f:	8b 45 0c             	mov    0xc(%ebp),%eax
 282:	0f b6 00             	movzbl (%eax),%eax
 285:	38 c2                	cmp    %al,%dl
 287:	74 de                	je     267 <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
 289:	8b 45 08             	mov    0x8(%ebp),%eax
 28c:	0f b6 00             	movzbl (%eax),%eax
 28f:	0f b6 d0             	movzbl %al,%edx
 292:	8b 45 0c             	mov    0xc(%ebp),%eax
 295:	0f b6 00             	movzbl (%eax),%eax
 298:	0f b6 c8             	movzbl %al,%ecx
 29b:	89 d0                	mov    %edx,%eax
 29d:	29 c8                	sub    %ecx,%eax
}
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret    

000002a1 <strlen>:

uint
strlen(const char *s)
{
 2a1:	55                   	push   %ebp
 2a2:	89 e5                	mov    %esp,%ebp
 2a4:	83 ec 10             	sub    $0x10,%esp
 2a7:	e8 ff 01 00 00       	call   4ab <__x86.get_pc_thunk.ax>
 2ac:	05 b0 0a 00 00       	add    $0xab0,%eax
  int n;

  for(n = 0; s[n]; n++)
 2b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 2b8:	eb 04                	jmp    2be <strlen+0x1d>
 2ba:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2be:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2c1:	8b 45 08             	mov    0x8(%ebp),%eax
 2c4:	01 d0                	add    %edx,%eax
 2c6:	0f b6 00             	movzbl (%eax),%eax
 2c9:	84 c0                	test   %al,%al
 2cb:	75 ed                	jne    2ba <strlen+0x19>
    ;
  return n;
 2cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2d0:	c9                   	leave  
 2d1:	c3                   	ret    

000002d2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2d2:	55                   	push   %ebp
 2d3:	89 e5                	mov    %esp,%ebp
 2d5:	e8 d1 01 00 00       	call   4ab <__x86.get_pc_thunk.ax>
 2da:	05 82 0a 00 00       	add    $0xa82,%eax
  stosb(dst, c, n);
 2df:	8b 45 10             	mov    0x10(%ebp),%eax
 2e2:	50                   	push   %eax
 2e3:	ff 75 0c             	push   0xc(%ebp)
 2e6:	ff 75 08             	push   0x8(%ebp)
 2e9:	e8 00 ff ff ff       	call   1ee <stosb>
 2ee:	83 c4 0c             	add    $0xc,%esp
  return dst;
 2f1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2f4:	c9                   	leave  
 2f5:	c3                   	ret    

000002f6 <strchr>:

char*
strchr(const char *s, char c)
{
 2f6:	55                   	push   %ebp
 2f7:	89 e5                	mov    %esp,%ebp
 2f9:	83 ec 04             	sub    $0x4,%esp
 2fc:	e8 aa 01 00 00       	call   4ab <__x86.get_pc_thunk.ax>
 301:	05 5b 0a 00 00       	add    $0xa5b,%eax
 306:	8b 45 0c             	mov    0xc(%ebp),%eax
 309:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 30c:	eb 14                	jmp    322 <strchr+0x2c>
    if(*s == c)
 30e:	8b 45 08             	mov    0x8(%ebp),%eax
 311:	0f b6 00             	movzbl (%eax),%eax
 314:	38 45 fc             	cmp    %al,-0x4(%ebp)
 317:	75 05                	jne    31e <strchr+0x28>
      return (char*)s;
 319:	8b 45 08             	mov    0x8(%ebp),%eax
 31c:	eb 13                	jmp    331 <strchr+0x3b>
  for(; *s; s++)
 31e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 322:	8b 45 08             	mov    0x8(%ebp),%eax
 325:	0f b6 00             	movzbl (%eax),%eax
 328:	84 c0                	test   %al,%al
 32a:	75 e2                	jne    30e <strchr+0x18>
  return 0;
 32c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 331:	c9                   	leave  
 332:	c3                   	ret    

00000333 <gets>:

char*
gets(char *buf, int max)
{
 333:	55                   	push   %ebp
 334:	89 e5                	mov    %esp,%ebp
 336:	53                   	push   %ebx
 337:	83 ec 14             	sub    $0x14,%esp
 33a:	e8 ab fe ff ff       	call   1ea <__x86.get_pc_thunk.bx>
 33f:	81 c3 1d 0a 00 00    	add    $0xa1d,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 345:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 34c:	eb 42                	jmp    390 <gets+0x5d>
    cc = read(0, &c, 1);
 34e:	83 ec 04             	sub    $0x4,%esp
 351:	6a 01                	push   $0x1
 353:	8d 45 ef             	lea    -0x11(%ebp),%eax
 356:	50                   	push   %eax
 357:	6a 00                	push   $0x0
 359:	e8 71 01 00 00       	call   4cf <read>
 35e:	83 c4 10             	add    $0x10,%esp
 361:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 364:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 368:	7e 33                	jle    39d <gets+0x6a>
      break;
    buf[i++] = c;
 36a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 36d:	8d 50 01             	lea    0x1(%eax),%edx
 370:	89 55 f4             	mov    %edx,-0xc(%ebp)
 373:	89 c2                	mov    %eax,%edx
 375:	8b 45 08             	mov    0x8(%ebp),%eax
 378:	01 c2                	add    %eax,%edx
 37a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 37e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 380:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 384:	3c 0a                	cmp    $0xa,%al
 386:	74 16                	je     39e <gets+0x6b>
 388:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 38c:	3c 0d                	cmp    $0xd,%al
 38e:	74 0e                	je     39e <gets+0x6b>
  for(i=0; i+1 < max; ){
 390:	8b 45 f4             	mov    -0xc(%ebp),%eax
 393:	83 c0 01             	add    $0x1,%eax
 396:	39 45 0c             	cmp    %eax,0xc(%ebp)
 399:	7f b3                	jg     34e <gets+0x1b>
 39b:	eb 01                	jmp    39e <gets+0x6b>
      break;
 39d:	90                   	nop
      break;
  }
  buf[i] = '\0';
 39e:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3a1:	8b 45 08             	mov    0x8(%ebp),%eax
 3a4:	01 d0                	add    %edx,%eax
 3a6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 3a9:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3af:	c9                   	leave  
 3b0:	c3                   	ret    

000003b1 <stat>:

int
stat(const char *n, struct stat *st)
{
 3b1:	55                   	push   %ebp
 3b2:	89 e5                	mov    %esp,%ebp
 3b4:	53                   	push   %ebx
 3b5:	83 ec 14             	sub    $0x14,%esp
 3b8:	e8 2d fe ff ff       	call   1ea <__x86.get_pc_thunk.bx>
 3bd:	81 c3 9f 09 00 00    	add    $0x99f,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c3:	83 ec 08             	sub    $0x8,%esp
 3c6:	6a 00                	push   $0x0
 3c8:	ff 75 08             	push   0x8(%ebp)
 3cb:	e8 27 01 00 00       	call   4f7 <open>
 3d0:	83 c4 10             	add    $0x10,%esp
 3d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 3d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3da:	79 07                	jns    3e3 <stat+0x32>
    return -1;
 3dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3e1:	eb 25                	jmp    408 <stat+0x57>
  r = fstat(fd, st);
 3e3:	83 ec 08             	sub    $0x8,%esp
 3e6:	ff 75 0c             	push   0xc(%ebp)
 3e9:	ff 75 f4             	push   -0xc(%ebp)
 3ec:	e8 1e 01 00 00       	call   50f <fstat>
 3f1:	83 c4 10             	add    $0x10,%esp
 3f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 3f7:	83 ec 0c             	sub    $0xc,%esp
 3fa:	ff 75 f4             	push   -0xc(%ebp)
 3fd:	e8 dd 00 00 00       	call   4df <close>
 402:	83 c4 10             	add    $0x10,%esp
  return r;
 405:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 408:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 40b:	c9                   	leave  
 40c:	c3                   	ret    

0000040d <atoi>:

int
atoi(const char *s)
{
 40d:	55                   	push   %ebp
 40e:	89 e5                	mov    %esp,%ebp
 410:	83 ec 10             	sub    $0x10,%esp
 413:	e8 93 00 00 00       	call   4ab <__x86.get_pc_thunk.ax>
 418:	05 44 09 00 00       	add    $0x944,%eax
  int n;

  n = 0;
 41d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 424:	eb 25                	jmp    44b <atoi+0x3e>
    n = n*10 + *s++ - '0';
 426:	8b 55 fc             	mov    -0x4(%ebp),%edx
 429:	89 d0                	mov    %edx,%eax
 42b:	c1 e0 02             	shl    $0x2,%eax
 42e:	01 d0                	add    %edx,%eax
 430:	01 c0                	add    %eax,%eax
 432:	89 c1                	mov    %eax,%ecx
 434:	8b 45 08             	mov    0x8(%ebp),%eax
 437:	8d 50 01             	lea    0x1(%eax),%edx
 43a:	89 55 08             	mov    %edx,0x8(%ebp)
 43d:	0f b6 00             	movzbl (%eax),%eax
 440:	0f be c0             	movsbl %al,%eax
 443:	01 c8                	add    %ecx,%eax
 445:	83 e8 30             	sub    $0x30,%eax
 448:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 44b:	8b 45 08             	mov    0x8(%ebp),%eax
 44e:	0f b6 00             	movzbl (%eax),%eax
 451:	3c 2f                	cmp    $0x2f,%al
 453:	7e 0a                	jle    45f <atoi+0x52>
 455:	8b 45 08             	mov    0x8(%ebp),%eax
 458:	0f b6 00             	movzbl (%eax),%eax
 45b:	3c 39                	cmp    $0x39,%al
 45d:	7e c7                	jle    426 <atoi+0x19>
  return n;
 45f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 462:	c9                   	leave  
 463:	c3                   	ret    

00000464 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 464:	55                   	push   %ebp
 465:	89 e5                	mov    %esp,%ebp
 467:	83 ec 10             	sub    $0x10,%esp
 46a:	e8 3c 00 00 00       	call   4ab <__x86.get_pc_thunk.ax>
 46f:	05 ed 08 00 00       	add    $0x8ed,%eax
  char *dst;
  const char *src;

  dst = vdst;
 474:	8b 45 08             	mov    0x8(%ebp),%eax
 477:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 47a:	8b 45 0c             	mov    0xc(%ebp),%eax
 47d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 480:	eb 17                	jmp    499 <memmove+0x35>
    *dst++ = *src++;
 482:	8b 55 f8             	mov    -0x8(%ebp),%edx
 485:	8d 42 01             	lea    0x1(%edx),%eax
 488:	89 45 f8             	mov    %eax,-0x8(%ebp)
 48b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 48e:	8d 48 01             	lea    0x1(%eax),%ecx
 491:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 494:	0f b6 12             	movzbl (%edx),%edx
 497:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 499:	8b 45 10             	mov    0x10(%ebp),%eax
 49c:	8d 50 ff             	lea    -0x1(%eax),%edx
 49f:	89 55 10             	mov    %edx,0x10(%ebp)
 4a2:	85 c0                	test   %eax,%eax
 4a4:	7f dc                	jg     482 <memmove+0x1e>
  return vdst;
 4a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4a9:	c9                   	leave  
 4aa:	c3                   	ret    

000004ab <__x86.get_pc_thunk.ax>:
 4ab:	8b 04 24             	mov    (%esp),%eax
 4ae:	c3                   	ret    

000004af <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4af:	b8 01 00 00 00       	mov    $0x1,%eax
 4b4:	cd 40                	int    $0x40
 4b6:	c3                   	ret    

000004b7 <exit>:
SYSCALL(exit)
 4b7:	b8 02 00 00 00       	mov    $0x2,%eax
 4bc:	cd 40                	int    $0x40
 4be:	c3                   	ret    

000004bf <wait>:
SYSCALL(wait)
 4bf:	b8 03 00 00 00       	mov    $0x3,%eax
 4c4:	cd 40                	int    $0x40
 4c6:	c3                   	ret    

000004c7 <pipe>:
SYSCALL(pipe)
 4c7:	b8 04 00 00 00       	mov    $0x4,%eax
 4cc:	cd 40                	int    $0x40
 4ce:	c3                   	ret    

000004cf <read>:
SYSCALL(read)
 4cf:	b8 05 00 00 00       	mov    $0x5,%eax
 4d4:	cd 40                	int    $0x40
 4d6:	c3                   	ret    

000004d7 <write>:
SYSCALL(write)
 4d7:	b8 10 00 00 00       	mov    $0x10,%eax
 4dc:	cd 40                	int    $0x40
 4de:	c3                   	ret    

000004df <close>:
SYSCALL(close)
 4df:	b8 15 00 00 00       	mov    $0x15,%eax
 4e4:	cd 40                	int    $0x40
 4e6:	c3                   	ret    

000004e7 <kill>:
SYSCALL(kill)
 4e7:	b8 06 00 00 00       	mov    $0x6,%eax
 4ec:	cd 40                	int    $0x40
 4ee:	c3                   	ret    

000004ef <exec>:
SYSCALL(exec)
 4ef:	b8 07 00 00 00       	mov    $0x7,%eax
 4f4:	cd 40                	int    $0x40
 4f6:	c3                   	ret    

000004f7 <open>:
SYSCALL(open)
 4f7:	b8 0f 00 00 00       	mov    $0xf,%eax
 4fc:	cd 40                	int    $0x40
 4fe:	c3                   	ret    

000004ff <mknod>:
SYSCALL(mknod)
 4ff:	b8 11 00 00 00       	mov    $0x11,%eax
 504:	cd 40                	int    $0x40
 506:	c3                   	ret    

00000507 <unlink>:
SYSCALL(unlink)
 507:	b8 12 00 00 00       	mov    $0x12,%eax
 50c:	cd 40                	int    $0x40
 50e:	c3                   	ret    

0000050f <fstat>:
SYSCALL(fstat)
 50f:	b8 08 00 00 00       	mov    $0x8,%eax
 514:	cd 40                	int    $0x40
 516:	c3                   	ret    

00000517 <link>:
SYSCALL(link)
 517:	b8 13 00 00 00       	mov    $0x13,%eax
 51c:	cd 40                	int    $0x40
 51e:	c3                   	ret    

0000051f <mkdir>:
SYSCALL(mkdir)
 51f:	b8 14 00 00 00       	mov    $0x14,%eax
 524:	cd 40                	int    $0x40
 526:	c3                   	ret    

00000527 <chdir>:
SYSCALL(chdir)
 527:	b8 09 00 00 00       	mov    $0x9,%eax
 52c:	cd 40                	int    $0x40
 52e:	c3                   	ret    

0000052f <dup>:
SYSCALL(dup)
 52f:	b8 0a 00 00 00       	mov    $0xa,%eax
 534:	cd 40                	int    $0x40
 536:	c3                   	ret    

00000537 <getpid>:
SYSCALL(getpid)
 537:	b8 0b 00 00 00       	mov    $0xb,%eax
 53c:	cd 40                	int    $0x40
 53e:	c3                   	ret    

0000053f <sbrk>:
SYSCALL(sbrk)
 53f:	b8 0c 00 00 00       	mov    $0xc,%eax
 544:	cd 40                	int    $0x40
 546:	c3                   	ret    

00000547 <sleep>:
SYSCALL(sleep)
 547:	b8 0d 00 00 00       	mov    $0xd,%eax
 54c:	cd 40                	int    $0x40
 54e:	c3                   	ret    

0000054f <uptime>:
SYSCALL(uptime)
 54f:	b8 0e 00 00 00       	mov    $0xe,%eax
 554:	cd 40                	int    $0x40
 556:	c3                   	ret    

00000557 <random>:
SYSCALL(random)
 557:	b8 16 00 00 00       	mov    $0x16,%eax
 55c:	cd 40                	int    $0x40
 55e:	c3                   	ret    

0000055f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 55f:	55                   	push   %ebp
 560:	89 e5                	mov    %esp,%ebp
 562:	53                   	push   %ebx
 563:	83 ec 14             	sub    $0x14,%esp
 566:	e8 40 ff ff ff       	call   4ab <__x86.get_pc_thunk.ax>
 56b:	05 f1 07 00 00       	add    $0x7f1,%eax
 570:	8b 55 0c             	mov    0xc(%ebp),%edx
 573:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 576:	83 ec 04             	sub    $0x4,%esp
 579:	6a 01                	push   $0x1
 57b:	8d 55 f4             	lea    -0xc(%ebp),%edx
 57e:	52                   	push   %edx
 57f:	ff 75 08             	push   0x8(%ebp)
 582:	89 c3                	mov    %eax,%ebx
 584:	e8 4e ff ff ff       	call   4d7 <write>
 589:	83 c4 10             	add    $0x10,%esp
}
 58c:	90                   	nop
 58d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 590:	c9                   	leave  
 591:	c3                   	ret    

00000592 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 592:	55                   	push   %ebp
 593:	89 e5                	mov    %esp,%ebp
 595:	53                   	push   %ebx
 596:	83 ec 24             	sub    $0x24,%esp
 599:	e8 58 02 00 00       	call   7f6 <__x86.get_pc_thunk.cx>
 59e:	81 c1 be 07 00 00    	add    $0x7be,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5a4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5ab:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 5af:	74 17                	je     5c8 <printint+0x36>
 5b1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 5b5:	79 11                	jns    5c8 <printint+0x36>
    neg = 1;
 5b7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 5be:	8b 45 0c             	mov    0xc(%ebp),%eax
 5c1:	f7 d8                	neg    %eax
 5c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5c6:	eb 06                	jmp    5ce <printint+0x3c>
  } else {
    x = xx;
 5c8:	8b 45 0c             	mov    0xc(%ebp),%eax
 5cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 5ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 5d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5db:	ba 00 00 00 00       	mov    $0x0,%edx
 5e0:	f7 f3                	div    %ebx
 5e2:	89 d3                	mov    %edx,%ebx
 5e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e7:	8d 50 01             	lea    0x1(%eax),%edx
 5ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5ed:	0f b6 94 19 0c 00 00 	movzbl 0xc(%ecx,%ebx,1),%edx
 5f4:	00 
 5f5:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 5f9:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5ff:	ba 00 00 00 00       	mov    $0x0,%edx
 604:	f7 f3                	div    %ebx
 606:	89 45 ec             	mov    %eax,-0x14(%ebp)
 609:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 60d:	75 c6                	jne    5d5 <printint+0x43>
  if(neg)
 60f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 613:	74 2d                	je     642 <printint+0xb0>
    buf[i++] = '-';
 615:	8b 45 f4             	mov    -0xc(%ebp),%eax
 618:	8d 50 01             	lea    0x1(%eax),%edx
 61b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 61e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 623:	eb 1d                	jmp    642 <printint+0xb0>
    putc(fd, buf[i]);
 625:	8d 55 dc             	lea    -0x24(%ebp),%edx
 628:	8b 45 f4             	mov    -0xc(%ebp),%eax
 62b:	01 d0                	add    %edx,%eax
 62d:	0f b6 00             	movzbl (%eax),%eax
 630:	0f be c0             	movsbl %al,%eax
 633:	83 ec 08             	sub    $0x8,%esp
 636:	50                   	push   %eax
 637:	ff 75 08             	push   0x8(%ebp)
 63a:	e8 20 ff ff ff       	call   55f <putc>
 63f:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 642:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 646:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 64a:	79 d9                	jns    625 <printint+0x93>
}
 64c:	90                   	nop
 64d:	90                   	nop
 64e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 651:	c9                   	leave  
 652:	c3                   	ret    

00000653 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 653:	55                   	push   %ebp
 654:	89 e5                	mov    %esp,%ebp
 656:	53                   	push   %ebx
 657:	83 ec 24             	sub    $0x24,%esp
 65a:	e8 8b fb ff ff       	call   1ea <__x86.get_pc_thunk.bx>
 65f:	81 c3 fd 06 00 00    	add    $0x6fd,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 665:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 66c:	8d 45 0c             	lea    0xc(%ebp),%eax
 66f:	83 c0 04             	add    $0x4,%eax
 672:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 675:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 67c:	e9 5b 01 00 00       	jmp    7dc <printf+0x189>
    c = fmt[i] & 0xff;
 681:	8b 55 0c             	mov    0xc(%ebp),%edx
 684:	8b 45 f0             	mov    -0x10(%ebp),%eax
 687:	01 d0                	add    %edx,%eax
 689:	0f b6 00             	movzbl (%eax),%eax
 68c:	0f be c0             	movsbl %al,%eax
 68f:	25 ff 00 00 00       	and    $0xff,%eax
 694:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 697:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 69b:	75 2c                	jne    6c9 <printf+0x76>
      if(c == '%'){
 69d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6a1:	75 0c                	jne    6af <printf+0x5c>
        state = '%';
 6a3:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6aa:	e9 29 01 00 00       	jmp    7d8 <printf+0x185>
      } else {
        putc(fd, c);
 6af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6b2:	0f be c0             	movsbl %al,%eax
 6b5:	83 ec 08             	sub    $0x8,%esp
 6b8:	50                   	push   %eax
 6b9:	ff 75 08             	push   0x8(%ebp)
 6bc:	e8 9e fe ff ff       	call   55f <putc>
 6c1:	83 c4 10             	add    $0x10,%esp
 6c4:	e9 0f 01 00 00       	jmp    7d8 <printf+0x185>
      }
    } else if(state == '%'){
 6c9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 6cd:	0f 85 05 01 00 00    	jne    7d8 <printf+0x185>
      if(c == 'd'){
 6d3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 6d7:	75 1e                	jne    6f7 <printf+0xa4>
        printint(fd, *ap, 10, 1);
 6d9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6dc:	8b 00                	mov    (%eax),%eax
 6de:	6a 01                	push   $0x1
 6e0:	6a 0a                	push   $0xa
 6e2:	50                   	push   %eax
 6e3:	ff 75 08             	push   0x8(%ebp)
 6e6:	e8 a7 fe ff ff       	call   592 <printint>
 6eb:	83 c4 10             	add    $0x10,%esp
        ap++;
 6ee:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6f2:	e9 da 00 00 00       	jmp    7d1 <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 6f7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 6fb:	74 06                	je     703 <printf+0xb0>
 6fd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 701:	75 1e                	jne    721 <printf+0xce>
        printint(fd, *ap, 16, 0);
 703:	8b 45 e8             	mov    -0x18(%ebp),%eax
 706:	8b 00                	mov    (%eax),%eax
 708:	6a 00                	push   $0x0
 70a:	6a 10                	push   $0x10
 70c:	50                   	push   %eax
 70d:	ff 75 08             	push   0x8(%ebp)
 710:	e8 7d fe ff ff       	call   592 <printint>
 715:	83 c4 10             	add    $0x10,%esp
        ap++;
 718:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 71c:	e9 b0 00 00 00       	jmp    7d1 <printf+0x17e>
      } else if(c == 's'){
 721:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 725:	75 45                	jne    76c <printf+0x119>
        s = (char*)*ap;
 727:	8b 45 e8             	mov    -0x18(%ebp),%eax
 72a:	8b 00                	mov    (%eax),%eax
 72c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 72f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 733:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 737:	75 27                	jne    760 <printf+0x10d>
          s = "(null)";
 739:	8d 83 2e fd ff ff    	lea    -0x2d2(%ebx),%eax
 73f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 742:	eb 1c                	jmp    760 <printf+0x10d>
          putc(fd, *s);
 744:	8b 45 f4             	mov    -0xc(%ebp),%eax
 747:	0f b6 00             	movzbl (%eax),%eax
 74a:	0f be c0             	movsbl %al,%eax
 74d:	83 ec 08             	sub    $0x8,%esp
 750:	50                   	push   %eax
 751:	ff 75 08             	push   0x8(%ebp)
 754:	e8 06 fe ff ff       	call   55f <putc>
 759:	83 c4 10             	add    $0x10,%esp
          s++;
 75c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 760:	8b 45 f4             	mov    -0xc(%ebp),%eax
 763:	0f b6 00             	movzbl (%eax),%eax
 766:	84 c0                	test   %al,%al
 768:	75 da                	jne    744 <printf+0xf1>
 76a:	eb 65                	jmp    7d1 <printf+0x17e>
        }
      } else if(c == 'c'){
 76c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 770:	75 1d                	jne    78f <printf+0x13c>
        putc(fd, *ap);
 772:	8b 45 e8             	mov    -0x18(%ebp),%eax
 775:	8b 00                	mov    (%eax),%eax
 777:	0f be c0             	movsbl %al,%eax
 77a:	83 ec 08             	sub    $0x8,%esp
 77d:	50                   	push   %eax
 77e:	ff 75 08             	push   0x8(%ebp)
 781:	e8 d9 fd ff ff       	call   55f <putc>
 786:	83 c4 10             	add    $0x10,%esp
        ap++;
 789:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 78d:	eb 42                	jmp    7d1 <printf+0x17e>
      } else if(c == '%'){
 78f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 793:	75 17                	jne    7ac <printf+0x159>
        putc(fd, c);
 795:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 798:	0f be c0             	movsbl %al,%eax
 79b:	83 ec 08             	sub    $0x8,%esp
 79e:	50                   	push   %eax
 79f:	ff 75 08             	push   0x8(%ebp)
 7a2:	e8 b8 fd ff ff       	call   55f <putc>
 7a7:	83 c4 10             	add    $0x10,%esp
 7aa:	eb 25                	jmp    7d1 <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7ac:	83 ec 08             	sub    $0x8,%esp
 7af:	6a 25                	push   $0x25
 7b1:	ff 75 08             	push   0x8(%ebp)
 7b4:	e8 a6 fd ff ff       	call   55f <putc>
 7b9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 7bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7bf:	0f be c0             	movsbl %al,%eax
 7c2:	83 ec 08             	sub    $0x8,%esp
 7c5:	50                   	push   %eax
 7c6:	ff 75 08             	push   0x8(%ebp)
 7c9:	e8 91 fd ff ff       	call   55f <putc>
 7ce:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 7d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 7d8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 7dc:	8b 55 0c             	mov    0xc(%ebp),%edx
 7df:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e2:	01 d0                	add    %edx,%eax
 7e4:	0f b6 00             	movzbl (%eax),%eax
 7e7:	84 c0                	test   %al,%al
 7e9:	0f 85 92 fe ff ff    	jne    681 <printf+0x2e>
    }
  }
}
 7ef:	90                   	nop
 7f0:	90                   	nop
 7f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7f4:	c9                   	leave  
 7f5:	c3                   	ret    

000007f6 <__x86.get_pc_thunk.cx>:
 7f6:	8b 0c 24             	mov    (%esp),%ecx
 7f9:	c3                   	ret    

000007fa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7fa:	55                   	push   %ebp
 7fb:	89 e5                	mov    %esp,%ebp
 7fd:	83 ec 10             	sub    $0x10,%esp
 800:	e8 a6 fc ff ff       	call   4ab <__x86.get_pc_thunk.ax>
 805:	05 57 05 00 00       	add    $0x557,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 80a:	8b 55 08             	mov    0x8(%ebp),%edx
 80d:	83 ea 08             	sub    $0x8,%edx
 810:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 813:	8b 90 2c 02 00 00    	mov    0x22c(%eax),%edx
 819:	89 55 fc             	mov    %edx,-0x4(%ebp)
 81c:	eb 24                	jmp    842 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 81e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 821:	8b 12                	mov    (%edx),%edx
 823:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 826:	72 12                	jb     83a <free+0x40>
 828:	8b 55 f8             	mov    -0x8(%ebp),%edx
 82b:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 82e:	77 24                	ja     854 <free+0x5a>
 830:	8b 55 fc             	mov    -0x4(%ebp),%edx
 833:	8b 12                	mov    (%edx),%edx
 835:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 838:	72 1a                	jb     854 <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 83d:	8b 12                	mov    (%edx),%edx
 83f:	89 55 fc             	mov    %edx,-0x4(%ebp)
 842:	8b 55 f8             	mov    -0x8(%ebp),%edx
 845:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 848:	76 d4                	jbe    81e <free+0x24>
 84a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 84d:	8b 12                	mov    (%edx),%edx
 84f:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 852:	73 ca                	jae    81e <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 854:	8b 55 f8             	mov    -0x8(%ebp),%edx
 857:	8b 52 04             	mov    0x4(%edx),%edx
 85a:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 861:	8b 55 f8             	mov    -0x8(%ebp),%edx
 864:	01 d1                	add    %edx,%ecx
 866:	8b 55 fc             	mov    -0x4(%ebp),%edx
 869:	8b 12                	mov    (%edx),%edx
 86b:	39 d1                	cmp    %edx,%ecx
 86d:	75 24                	jne    893 <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 86f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 872:	8b 4a 04             	mov    0x4(%edx),%ecx
 875:	8b 55 fc             	mov    -0x4(%ebp),%edx
 878:	8b 12                	mov    (%edx),%edx
 87a:	8b 52 04             	mov    0x4(%edx),%edx
 87d:	01 d1                	add    %edx,%ecx
 87f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 882:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 885:	8b 55 fc             	mov    -0x4(%ebp),%edx
 888:	8b 12                	mov    (%edx),%edx
 88a:	8b 0a                	mov    (%edx),%ecx
 88c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 88f:	89 0a                	mov    %ecx,(%edx)
 891:	eb 0a                	jmp    89d <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 893:	8b 55 fc             	mov    -0x4(%ebp),%edx
 896:	8b 0a                	mov    (%edx),%ecx
 898:	8b 55 f8             	mov    -0x8(%ebp),%edx
 89b:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 89d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 8a0:	8b 52 04             	mov    0x4(%edx),%edx
 8a3:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 8aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
 8ad:	01 ca                	add    %ecx,%edx
 8af:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 8b2:	75 20                	jne    8d4 <free+0xda>
    p->s.size += bp->s.size;
 8b4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 8b7:	8b 4a 04             	mov    0x4(%edx),%ecx
 8ba:	8b 55 f8             	mov    -0x8(%ebp),%edx
 8bd:	8b 52 04             	mov    0x4(%edx),%edx
 8c0:	01 d1                	add    %edx,%ecx
 8c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 8c5:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 8c8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 8cb:	8b 0a                	mov    (%edx),%ecx
 8cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
 8d0:	89 0a                	mov    %ecx,(%edx)
 8d2:	eb 08                	jmp    8dc <free+0xe2>
  } else
    p->s.ptr = bp;
 8d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 8d7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 8da:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 8dc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 8df:	89 90 2c 02 00 00    	mov    %edx,0x22c(%eax)
}
 8e5:	90                   	nop
 8e6:	c9                   	leave  
 8e7:	c3                   	ret    

000008e8 <morecore>:

static Header*
morecore(uint nu)
{
 8e8:	55                   	push   %ebp
 8e9:	89 e5                	mov    %esp,%ebp
 8eb:	53                   	push   %ebx
 8ec:	83 ec 14             	sub    $0x14,%esp
 8ef:	e8 f6 f8 ff ff       	call   1ea <__x86.get_pc_thunk.bx>
 8f4:	81 c3 68 04 00 00    	add    $0x468,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 8fa:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 901:	77 07                	ja     90a <morecore+0x22>
    nu = 4096;
 903:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 90a:	8b 45 08             	mov    0x8(%ebp),%eax
 90d:	c1 e0 03             	shl    $0x3,%eax
 910:	83 ec 0c             	sub    $0xc,%esp
 913:	50                   	push   %eax
 914:	e8 26 fc ff ff       	call   53f <sbrk>
 919:	83 c4 10             	add    $0x10,%esp
 91c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 91f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 923:	75 07                	jne    92c <morecore+0x44>
    return 0;
 925:	b8 00 00 00 00       	mov    $0x0,%eax
 92a:	eb 27                	jmp    953 <morecore+0x6b>
  hp = (Header*)p;
 92c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 932:	8b 45 f0             	mov    -0x10(%ebp),%eax
 935:	8b 55 08             	mov    0x8(%ebp),%edx
 938:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 93b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 93e:	83 c0 08             	add    $0x8,%eax
 941:	83 ec 0c             	sub    $0xc,%esp
 944:	50                   	push   %eax
 945:	e8 b0 fe ff ff       	call   7fa <free>
 94a:	83 c4 10             	add    $0x10,%esp
  return freep;
 94d:	8b 83 2c 02 00 00    	mov    0x22c(%ebx),%eax
}
 953:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 956:	c9                   	leave  
 957:	c3                   	ret    

00000958 <malloc>:

void*
malloc(uint nbytes)
{
 958:	55                   	push   %ebp
 959:	89 e5                	mov    %esp,%ebp
 95b:	53                   	push   %ebx
 95c:	83 ec 14             	sub    $0x14,%esp
 95f:	e8 86 f8 ff ff       	call   1ea <__x86.get_pc_thunk.bx>
 964:	81 c3 f8 03 00 00    	add    $0x3f8,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 96a:	8b 45 08             	mov    0x8(%ebp),%eax
 96d:	83 c0 07             	add    $0x7,%eax
 970:	c1 e8 03             	shr    $0x3,%eax
 973:	83 c0 01             	add    $0x1,%eax
 976:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 979:	8b 83 2c 02 00 00    	mov    0x22c(%ebx),%eax
 97f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 982:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 986:	75 28                	jne    9b0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 988:	8d 83 24 02 00 00    	lea    0x224(%ebx),%eax
 98e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 991:	8b 45 f0             	mov    -0x10(%ebp),%eax
 994:	89 83 2c 02 00 00    	mov    %eax,0x22c(%ebx)
 99a:	8b 83 2c 02 00 00    	mov    0x22c(%ebx),%eax
 9a0:	89 83 24 02 00 00    	mov    %eax,0x224(%ebx)
    base.s.size = 0;
 9a6:	c7 83 28 02 00 00 00 	movl   $0x0,0x228(%ebx)
 9ad:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9b3:	8b 00                	mov    (%eax),%eax
 9b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9bb:	8b 40 04             	mov    0x4(%eax),%eax
 9be:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 9c1:	77 4e                	ja     a11 <malloc+0xb9>
      if(p->s.size == nunits)
 9c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c6:	8b 40 04             	mov    0x4(%eax),%eax
 9c9:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 9cc:	75 0c                	jne    9da <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 9ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d1:	8b 10                	mov    (%eax),%edx
 9d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9d6:	89 10                	mov    %edx,(%eax)
 9d8:	eb 26                	jmp    a00 <malloc+0xa8>
      else {
        p->s.size -= nunits;
 9da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9dd:	8b 40 04             	mov    0x4(%eax),%eax
 9e0:	2b 45 ec             	sub    -0x14(%ebp),%eax
 9e3:	89 c2                	mov    %eax,%edx
 9e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e8:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ee:	8b 40 04             	mov    0x4(%eax),%eax
 9f1:	c1 e0 03             	shl    $0x3,%eax
 9f4:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 9f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9fa:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9fd:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a00:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a03:	89 83 2c 02 00 00    	mov    %eax,0x22c(%ebx)
      return (void*)(p + 1);
 a09:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a0c:	83 c0 08             	add    $0x8,%eax
 a0f:	eb 3c                	jmp    a4d <malloc+0xf5>
    }
    if(p == freep)
 a11:	8b 83 2c 02 00 00    	mov    0x22c(%ebx),%eax
 a17:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a1a:	75 1e                	jne    a3a <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 a1c:	83 ec 0c             	sub    $0xc,%esp
 a1f:	ff 75 ec             	push   -0x14(%ebp)
 a22:	e8 c1 fe ff ff       	call   8e8 <morecore>
 a27:	83 c4 10             	add    $0x10,%esp
 a2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a31:	75 07                	jne    a3a <malloc+0xe2>
        return 0;
 a33:	b8 00 00 00 00       	mov    $0x0,%eax
 a38:	eb 13                	jmp    a4d <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a40:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a43:	8b 00                	mov    (%eax),%eax
 a45:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a48:	e9 6b ff ff ff       	jmp    9b8 <malloc+0x60>
  }
}
 a4d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 a50:	c9                   	leave  
 a51:	c3                   	ret    
