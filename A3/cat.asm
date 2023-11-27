
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
   7:	e8 44 01 00 00       	call   150 <__x86.get_pc_thunk.bx>
   c:	81 c3 b4 0c 00 00    	add    $0xcb4,%ebx
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  12:	eb 35                	jmp    49 <cat+0x49>
    if (write(1, buf, n) != n) {
  14:	83 ec 04             	sub    $0x4,%esp
  17:	ff 75 f4             	push   -0xc(%ebp)
  1a:	8d 83 20 00 00 00    	lea    0x20(%ebx),%eax
  20:	50                   	push   %eax
  21:	6a 01                	push   $0x1
  23:	e8 15 04 00 00       	call   43d <write>
  28:	83 c4 10             	add    $0x10,%esp
  2b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  2e:	74 19                	je     49 <cat+0x49>
      printf(1, "cat: write error\n");
  30:	83 ec 08             	sub    $0x8,%esp
  33:	8d 83 f8 fc ff ff    	lea    -0x308(%ebx),%eax
  39:	50                   	push   %eax
  3a:	6a 01                	push   $0x1
  3c:	e8 78 05 00 00       	call   5b9 <printf>
  41:	83 c4 10             	add    $0x10,%esp
      exit();
  44:	e8 d4 03 00 00       	call   41d <exit>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  49:	83 ec 04             	sub    $0x4,%esp
  4c:	68 00 02 00 00       	push   $0x200
  51:	8d 83 20 00 00 00    	lea    0x20(%ebx),%eax
  57:	50                   	push   %eax
  58:	ff 75 08             	push   0x8(%ebp)
  5b:	e8 d5 03 00 00       	call   435 <read>
  60:	83 c4 10             	add    $0x10,%esp
  63:	89 45 f4             	mov    %eax,-0xc(%ebp)
  66:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  6a:	7f a8                	jg     14 <cat+0x14>
    }
  }
  if(n < 0){
  6c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  70:	79 19                	jns    8b <cat+0x8b>
    printf(1, "cat: read error\n");
  72:	83 ec 08             	sub    $0x8,%esp
  75:	8d 83 0a fd ff ff    	lea    -0x2f6(%ebx),%eax
  7b:	50                   	push   %eax
  7c:	6a 01                	push   $0x1
  7e:	e8 36 05 00 00       	call   5b9 <printf>
  83:	83 c4 10             	add    $0x10,%esp
    exit();
  86:	e8 92 03 00 00       	call   41d <exit>
  }
}
  8b:	90                   	nop
  8c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8f:	c9                   	leave  
  90:	c3                   	ret    

00000091 <main>:

int
main(int argc, char *argv[])
{
  91:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  95:	83 e4 f0             	and    $0xfffffff0,%esp
  98:	ff 71 fc             	push   -0x4(%ecx)
  9b:	55                   	push   %ebp
  9c:	89 e5                	mov    %esp,%ebp
  9e:	56                   	push   %esi
  9f:	53                   	push   %ebx
  a0:	51                   	push   %ecx
  a1:	83 ec 1c             	sub    $0x1c,%esp
  a4:	e8 a7 00 00 00       	call   150 <__x86.get_pc_thunk.bx>
  a9:	81 c3 17 0c 00 00    	add    $0xc17,%ebx
  af:	89 ce                	mov    %ecx,%esi
  int fd, i;

  if(argc <= 1){
  b1:	83 3e 01             	cmpl   $0x1,(%esi)
  b4:	7f 12                	jg     c8 <main+0x37>
    cat(0);
  b6:	83 ec 0c             	sub    $0xc,%esp
  b9:	6a 00                	push   $0x0
  bb:	e8 40 ff ff ff       	call   0 <cat>
  c0:	83 c4 10             	add    $0x10,%esp
    exit();
  c3:	e8 55 03 00 00       	call   41d <exit>
  }

  for(i = 1; i < argc; i++){
  c8:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  cf:	eb 73                	jmp    144 <main+0xb3>
    if((fd = open(argv[i], 0)) < 0){
  d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  d4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  db:	8b 46 04             	mov    0x4(%esi),%eax
  de:	01 d0                	add    %edx,%eax
  e0:	8b 00                	mov    (%eax),%eax
  e2:	83 ec 08             	sub    $0x8,%esp
  e5:	6a 00                	push   $0x0
  e7:	50                   	push   %eax
  e8:	e8 70 03 00 00       	call   45d <open>
  ed:	83 c4 10             	add    $0x10,%esp
  f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  f7:	79 2b                	jns    124 <main+0x93>
      printf(1, "cat: cannot open %s\n", argv[i]);
  f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  fc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 103:	8b 46 04             	mov    0x4(%esi),%eax
 106:	01 d0                	add    %edx,%eax
 108:	8b 00                	mov    (%eax),%eax
 10a:	83 ec 04             	sub    $0x4,%esp
 10d:	50                   	push   %eax
 10e:	8d 83 1b fd ff ff    	lea    -0x2e5(%ebx),%eax
 114:	50                   	push   %eax
 115:	6a 01                	push   $0x1
 117:	e8 9d 04 00 00       	call   5b9 <printf>
 11c:	83 c4 10             	add    $0x10,%esp
      exit();
 11f:	e8 f9 02 00 00       	call   41d <exit>
    }
    cat(fd);
 124:	83 ec 0c             	sub    $0xc,%esp
 127:	ff 75 e0             	push   -0x20(%ebp)
 12a:	e8 d1 fe ff ff       	call   0 <cat>
 12f:	83 c4 10             	add    $0x10,%esp
    close(fd);
 132:	83 ec 0c             	sub    $0xc,%esp
 135:	ff 75 e0             	push   -0x20(%ebp)
 138:	e8 08 03 00 00       	call   445 <close>
 13d:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
 140:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 144:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 147:	3b 06                	cmp    (%esi),%eax
 149:	7c 86                	jl     d1 <main+0x40>
  }
  exit();
 14b:	e8 cd 02 00 00       	call   41d <exit>

00000150 <__x86.get_pc_thunk.bx>:
 150:	8b 1c 24             	mov    (%esp),%ebx
 153:	c3                   	ret    

00000154 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 154:	55                   	push   %ebp
 155:	89 e5                	mov    %esp,%ebp
 157:	57                   	push   %edi
 158:	53                   	push   %ebx
 159:	e8 b3 02 00 00       	call   411 <__x86.get_pc_thunk.ax>
 15e:	05 62 0b 00 00       	add    $0xb62,%eax
  asm volatile("cld; rep stosb" :
 163:	8b 4d 08             	mov    0x8(%ebp),%ecx
 166:	8b 55 10             	mov    0x10(%ebp),%edx
 169:	8b 45 0c             	mov    0xc(%ebp),%eax
 16c:	89 cb                	mov    %ecx,%ebx
 16e:	89 df                	mov    %ebx,%edi
 170:	89 d1                	mov    %edx,%ecx
 172:	fc                   	cld    
 173:	f3 aa                	rep stos %al,%es:(%edi)
 175:	89 ca                	mov    %ecx,%edx
 177:	89 fb                	mov    %edi,%ebx
 179:	89 5d 08             	mov    %ebx,0x8(%ebp)
 17c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 17f:	90                   	nop
 180:	5b                   	pop    %ebx
 181:	5f                   	pop    %edi
 182:	5d                   	pop    %ebp
 183:	c3                   	ret    

00000184 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	83 ec 10             	sub    $0x10,%esp
 18a:	e8 82 02 00 00       	call   411 <__x86.get_pc_thunk.ax>
 18f:	05 31 0b 00 00       	add    $0xb31,%eax
  char *os;

  os = s;
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 19a:	90                   	nop
 19b:	8b 55 0c             	mov    0xc(%ebp),%edx
 19e:	8d 42 01             	lea    0x1(%edx),%eax
 1a1:	89 45 0c             	mov    %eax,0xc(%ebp)
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	8d 48 01             	lea    0x1(%eax),%ecx
 1aa:	89 4d 08             	mov    %ecx,0x8(%ebp)
 1ad:	0f b6 12             	movzbl (%edx),%edx
 1b0:	88 10                	mov    %dl,(%eax)
 1b2:	0f b6 00             	movzbl (%eax),%eax
 1b5:	84 c0                	test   %al,%al
 1b7:	75 e2                	jne    19b <strcpy+0x17>
    ;
  return os;
 1b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1bc:	c9                   	leave  
 1bd:	c3                   	ret    

000001be <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1be:	55                   	push   %ebp
 1bf:	89 e5                	mov    %esp,%ebp
 1c1:	e8 4b 02 00 00       	call   411 <__x86.get_pc_thunk.ax>
 1c6:	05 fa 0a 00 00       	add    $0xafa,%eax
  while(*p && *p == *q)
 1cb:	eb 08                	jmp    1d5 <strcmp+0x17>
    p++, q++;
 1cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1d1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 1d5:	8b 45 08             	mov    0x8(%ebp),%eax
 1d8:	0f b6 00             	movzbl (%eax),%eax
 1db:	84 c0                	test   %al,%al
 1dd:	74 10                	je     1ef <strcmp+0x31>
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	0f b6 10             	movzbl (%eax),%edx
 1e5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e8:	0f b6 00             	movzbl (%eax),%eax
 1eb:	38 c2                	cmp    %al,%dl
 1ed:	74 de                	je     1cd <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
 1ef:	8b 45 08             	mov    0x8(%ebp),%eax
 1f2:	0f b6 00             	movzbl (%eax),%eax
 1f5:	0f b6 d0             	movzbl %al,%edx
 1f8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fb:	0f b6 00             	movzbl (%eax),%eax
 1fe:	0f b6 c8             	movzbl %al,%ecx
 201:	89 d0                	mov    %edx,%eax
 203:	29 c8                	sub    %ecx,%eax
}
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    

00000207 <strlen>:

uint
strlen(const char *s)
{
 207:	55                   	push   %ebp
 208:	89 e5                	mov    %esp,%ebp
 20a:	83 ec 10             	sub    $0x10,%esp
 20d:	e8 ff 01 00 00       	call   411 <__x86.get_pc_thunk.ax>
 212:	05 ae 0a 00 00       	add    $0xaae,%eax
  int n;

  for(n = 0; s[n]; n++)
 217:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 21e:	eb 04                	jmp    224 <strlen+0x1d>
 220:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 224:	8b 55 fc             	mov    -0x4(%ebp),%edx
 227:	8b 45 08             	mov    0x8(%ebp),%eax
 22a:	01 d0                	add    %edx,%eax
 22c:	0f b6 00             	movzbl (%eax),%eax
 22f:	84 c0                	test   %al,%al
 231:	75 ed                	jne    220 <strlen+0x19>
    ;
  return n;
 233:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 236:	c9                   	leave  
 237:	c3                   	ret    

00000238 <memset>:

void*
memset(void *dst, int c, uint n)
{
 238:	55                   	push   %ebp
 239:	89 e5                	mov    %esp,%ebp
 23b:	e8 d1 01 00 00       	call   411 <__x86.get_pc_thunk.ax>
 240:	05 80 0a 00 00       	add    $0xa80,%eax
  stosb(dst, c, n);
 245:	8b 45 10             	mov    0x10(%ebp),%eax
 248:	50                   	push   %eax
 249:	ff 75 0c             	push   0xc(%ebp)
 24c:	ff 75 08             	push   0x8(%ebp)
 24f:	e8 00 ff ff ff       	call   154 <stosb>
 254:	83 c4 0c             	add    $0xc,%esp
  return dst;
 257:	8b 45 08             	mov    0x8(%ebp),%eax
}
 25a:	c9                   	leave  
 25b:	c3                   	ret    

0000025c <strchr>:

char*
strchr(const char *s, char c)
{
 25c:	55                   	push   %ebp
 25d:	89 e5                	mov    %esp,%ebp
 25f:	83 ec 04             	sub    $0x4,%esp
 262:	e8 aa 01 00 00       	call   411 <__x86.get_pc_thunk.ax>
 267:	05 59 0a 00 00       	add    $0xa59,%eax
 26c:	8b 45 0c             	mov    0xc(%ebp),%eax
 26f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 272:	eb 14                	jmp    288 <strchr+0x2c>
    if(*s == c)
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	0f b6 00             	movzbl (%eax),%eax
 27a:	38 45 fc             	cmp    %al,-0x4(%ebp)
 27d:	75 05                	jne    284 <strchr+0x28>
      return (char*)s;
 27f:	8b 45 08             	mov    0x8(%ebp),%eax
 282:	eb 13                	jmp    297 <strchr+0x3b>
  for(; *s; s++)
 284:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	0f b6 00             	movzbl (%eax),%eax
 28e:	84 c0                	test   %al,%al
 290:	75 e2                	jne    274 <strchr+0x18>
  return 0;
 292:	b8 00 00 00 00       	mov    $0x0,%eax
}
 297:	c9                   	leave  
 298:	c3                   	ret    

00000299 <gets>:

char*
gets(char *buf, int max)
{
 299:	55                   	push   %ebp
 29a:	89 e5                	mov    %esp,%ebp
 29c:	53                   	push   %ebx
 29d:	83 ec 14             	sub    $0x14,%esp
 2a0:	e8 ab fe ff ff       	call   150 <__x86.get_pc_thunk.bx>
 2a5:	81 c3 1b 0a 00 00    	add    $0xa1b,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2b2:	eb 42                	jmp    2f6 <gets+0x5d>
    cc = read(0, &c, 1);
 2b4:	83 ec 04             	sub    $0x4,%esp
 2b7:	6a 01                	push   $0x1
 2b9:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2bc:	50                   	push   %eax
 2bd:	6a 00                	push   $0x0
 2bf:	e8 71 01 00 00       	call   435 <read>
 2c4:	83 c4 10             	add    $0x10,%esp
 2c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2ce:	7e 33                	jle    303 <gets+0x6a>
      break;
    buf[i++] = c;
 2d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2d3:	8d 50 01             	lea    0x1(%eax),%edx
 2d6:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2d9:	89 c2                	mov    %eax,%edx
 2db:	8b 45 08             	mov    0x8(%ebp),%eax
 2de:	01 c2                	add    %eax,%edx
 2e0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2e4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2e6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2ea:	3c 0a                	cmp    $0xa,%al
 2ec:	74 16                	je     304 <gets+0x6b>
 2ee:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2f2:	3c 0d                	cmp    $0xd,%al
 2f4:	74 0e                	je     304 <gets+0x6b>
  for(i=0; i+1 < max; ){
 2f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2f9:	83 c0 01             	add    $0x1,%eax
 2fc:	39 45 0c             	cmp    %eax,0xc(%ebp)
 2ff:	7f b3                	jg     2b4 <gets+0x1b>
 301:	eb 01                	jmp    304 <gets+0x6b>
      break;
 303:	90                   	nop
      break;
  }
  buf[i] = '\0';
 304:	8b 55 f4             	mov    -0xc(%ebp),%edx
 307:	8b 45 08             	mov    0x8(%ebp),%eax
 30a:	01 d0                	add    %edx,%eax
 30c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 30f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 312:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 315:	c9                   	leave  
 316:	c3                   	ret    

00000317 <stat>:

int
stat(const char *n, struct stat *st)
{
 317:	55                   	push   %ebp
 318:	89 e5                	mov    %esp,%ebp
 31a:	53                   	push   %ebx
 31b:	83 ec 14             	sub    $0x14,%esp
 31e:	e8 2d fe ff ff       	call   150 <__x86.get_pc_thunk.bx>
 323:	81 c3 9d 09 00 00    	add    $0x99d,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 329:	83 ec 08             	sub    $0x8,%esp
 32c:	6a 00                	push   $0x0
 32e:	ff 75 08             	push   0x8(%ebp)
 331:	e8 27 01 00 00       	call   45d <open>
 336:	83 c4 10             	add    $0x10,%esp
 339:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 33c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 340:	79 07                	jns    349 <stat+0x32>
    return -1;
 342:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 347:	eb 25                	jmp    36e <stat+0x57>
  r = fstat(fd, st);
 349:	83 ec 08             	sub    $0x8,%esp
 34c:	ff 75 0c             	push   0xc(%ebp)
 34f:	ff 75 f4             	push   -0xc(%ebp)
 352:	e8 1e 01 00 00       	call   475 <fstat>
 357:	83 c4 10             	add    $0x10,%esp
 35a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 35d:	83 ec 0c             	sub    $0xc,%esp
 360:	ff 75 f4             	push   -0xc(%ebp)
 363:	e8 dd 00 00 00       	call   445 <close>
 368:	83 c4 10             	add    $0x10,%esp
  return r;
 36b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 36e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 371:	c9                   	leave  
 372:	c3                   	ret    

00000373 <atoi>:

int
atoi(const char *s)
{
 373:	55                   	push   %ebp
 374:	89 e5                	mov    %esp,%ebp
 376:	83 ec 10             	sub    $0x10,%esp
 379:	e8 93 00 00 00       	call   411 <__x86.get_pc_thunk.ax>
 37e:	05 42 09 00 00       	add    $0x942,%eax
  int n;

  n = 0;
 383:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 38a:	eb 25                	jmp    3b1 <atoi+0x3e>
    n = n*10 + *s++ - '0';
 38c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 38f:	89 d0                	mov    %edx,%eax
 391:	c1 e0 02             	shl    $0x2,%eax
 394:	01 d0                	add    %edx,%eax
 396:	01 c0                	add    %eax,%eax
 398:	89 c1                	mov    %eax,%ecx
 39a:	8b 45 08             	mov    0x8(%ebp),%eax
 39d:	8d 50 01             	lea    0x1(%eax),%edx
 3a0:	89 55 08             	mov    %edx,0x8(%ebp)
 3a3:	0f b6 00             	movzbl (%eax),%eax
 3a6:	0f be c0             	movsbl %al,%eax
 3a9:	01 c8                	add    %ecx,%eax
 3ab:	83 e8 30             	sub    $0x30,%eax
 3ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3b1:	8b 45 08             	mov    0x8(%ebp),%eax
 3b4:	0f b6 00             	movzbl (%eax),%eax
 3b7:	3c 2f                	cmp    $0x2f,%al
 3b9:	7e 0a                	jle    3c5 <atoi+0x52>
 3bb:	8b 45 08             	mov    0x8(%ebp),%eax
 3be:	0f b6 00             	movzbl (%eax),%eax
 3c1:	3c 39                	cmp    $0x39,%al
 3c3:	7e c7                	jle    38c <atoi+0x19>
  return n;
 3c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3c8:	c9                   	leave  
 3c9:	c3                   	ret    

000003ca <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3ca:	55                   	push   %ebp
 3cb:	89 e5                	mov    %esp,%ebp
 3cd:	83 ec 10             	sub    $0x10,%esp
 3d0:	e8 3c 00 00 00       	call   411 <__x86.get_pc_thunk.ax>
 3d5:	05 eb 08 00 00       	add    $0x8eb,%eax
  char *dst;
  const char *src;

  dst = vdst;
 3da:	8b 45 08             	mov    0x8(%ebp),%eax
 3dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3e6:	eb 17                	jmp    3ff <memmove+0x35>
    *dst++ = *src++;
 3e8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3eb:	8d 42 01             	lea    0x1(%edx),%eax
 3ee:	89 45 f8             	mov    %eax,-0x8(%ebp)
 3f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3f4:	8d 48 01             	lea    0x1(%eax),%ecx
 3f7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 3fa:	0f b6 12             	movzbl (%edx),%edx
 3fd:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 3ff:	8b 45 10             	mov    0x10(%ebp),%eax
 402:	8d 50 ff             	lea    -0x1(%eax),%edx
 405:	89 55 10             	mov    %edx,0x10(%ebp)
 408:	85 c0                	test   %eax,%eax
 40a:	7f dc                	jg     3e8 <memmove+0x1e>
  return vdst;
 40c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 40f:	c9                   	leave  
 410:	c3                   	ret    

00000411 <__x86.get_pc_thunk.ax>:
 411:	8b 04 24             	mov    (%esp),%eax
 414:	c3                   	ret    

00000415 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 415:	b8 01 00 00 00       	mov    $0x1,%eax
 41a:	cd 40                	int    $0x40
 41c:	c3                   	ret    

0000041d <exit>:
SYSCALL(exit)
 41d:	b8 02 00 00 00       	mov    $0x2,%eax
 422:	cd 40                	int    $0x40
 424:	c3                   	ret    

00000425 <wait>:
SYSCALL(wait)
 425:	b8 03 00 00 00       	mov    $0x3,%eax
 42a:	cd 40                	int    $0x40
 42c:	c3                   	ret    

0000042d <pipe>:
SYSCALL(pipe)
 42d:	b8 04 00 00 00       	mov    $0x4,%eax
 432:	cd 40                	int    $0x40
 434:	c3                   	ret    

00000435 <read>:
SYSCALL(read)
 435:	b8 05 00 00 00       	mov    $0x5,%eax
 43a:	cd 40                	int    $0x40
 43c:	c3                   	ret    

0000043d <write>:
SYSCALL(write)
 43d:	b8 10 00 00 00       	mov    $0x10,%eax
 442:	cd 40                	int    $0x40
 444:	c3                   	ret    

00000445 <close>:
SYSCALL(close)
 445:	b8 15 00 00 00       	mov    $0x15,%eax
 44a:	cd 40                	int    $0x40
 44c:	c3                   	ret    

0000044d <kill>:
SYSCALL(kill)
 44d:	b8 06 00 00 00       	mov    $0x6,%eax
 452:	cd 40                	int    $0x40
 454:	c3                   	ret    

00000455 <exec>:
SYSCALL(exec)
 455:	b8 07 00 00 00       	mov    $0x7,%eax
 45a:	cd 40                	int    $0x40
 45c:	c3                   	ret    

0000045d <open>:
SYSCALL(open)
 45d:	b8 0f 00 00 00       	mov    $0xf,%eax
 462:	cd 40                	int    $0x40
 464:	c3                   	ret    

00000465 <mknod>:
SYSCALL(mknod)
 465:	b8 11 00 00 00       	mov    $0x11,%eax
 46a:	cd 40                	int    $0x40
 46c:	c3                   	ret    

0000046d <unlink>:
SYSCALL(unlink)
 46d:	b8 12 00 00 00       	mov    $0x12,%eax
 472:	cd 40                	int    $0x40
 474:	c3                   	ret    

00000475 <fstat>:
SYSCALL(fstat)
 475:	b8 08 00 00 00       	mov    $0x8,%eax
 47a:	cd 40                	int    $0x40
 47c:	c3                   	ret    

0000047d <link>:
SYSCALL(link)
 47d:	b8 13 00 00 00       	mov    $0x13,%eax
 482:	cd 40                	int    $0x40
 484:	c3                   	ret    

00000485 <mkdir>:
SYSCALL(mkdir)
 485:	b8 14 00 00 00       	mov    $0x14,%eax
 48a:	cd 40                	int    $0x40
 48c:	c3                   	ret    

0000048d <chdir>:
SYSCALL(chdir)
 48d:	b8 09 00 00 00       	mov    $0x9,%eax
 492:	cd 40                	int    $0x40
 494:	c3                   	ret    

00000495 <dup>:
SYSCALL(dup)
 495:	b8 0a 00 00 00       	mov    $0xa,%eax
 49a:	cd 40                	int    $0x40
 49c:	c3                   	ret    

0000049d <getpid>:
SYSCALL(getpid)
 49d:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a2:	cd 40                	int    $0x40
 4a4:	c3                   	ret    

000004a5 <sbrk>:
SYSCALL(sbrk)
 4a5:	b8 0c 00 00 00       	mov    $0xc,%eax
 4aa:	cd 40                	int    $0x40
 4ac:	c3                   	ret    

000004ad <sleep>:
SYSCALL(sleep)
 4ad:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b2:	cd 40                	int    $0x40
 4b4:	c3                   	ret    

000004b5 <uptime>:
SYSCALL(uptime)
 4b5:	b8 0e 00 00 00       	mov    $0xe,%eax
 4ba:	cd 40                	int    $0x40
 4bc:	c3                   	ret    

000004bd <random>:
SYSCALL(random)
 4bd:	b8 16 00 00 00       	mov    $0x16,%eax
 4c2:	cd 40                	int    $0x40
 4c4:	c3                   	ret    

000004c5 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4c5:	55                   	push   %ebp
 4c6:	89 e5                	mov    %esp,%ebp
 4c8:	53                   	push   %ebx
 4c9:	83 ec 14             	sub    $0x14,%esp
 4cc:	e8 40 ff ff ff       	call   411 <__x86.get_pc_thunk.ax>
 4d1:	05 ef 07 00 00       	add    $0x7ef,%eax
 4d6:	8b 55 0c             	mov    0xc(%ebp),%edx
 4d9:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 4dc:	83 ec 04             	sub    $0x4,%esp
 4df:	6a 01                	push   $0x1
 4e1:	8d 55 f4             	lea    -0xc(%ebp),%edx
 4e4:	52                   	push   %edx
 4e5:	ff 75 08             	push   0x8(%ebp)
 4e8:	89 c3                	mov    %eax,%ebx
 4ea:	e8 4e ff ff ff       	call   43d <write>
 4ef:	83 c4 10             	add    $0x10,%esp
}
 4f2:	90                   	nop
 4f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4f6:	c9                   	leave  
 4f7:	c3                   	ret    

000004f8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4f8:	55                   	push   %ebp
 4f9:	89 e5                	mov    %esp,%ebp
 4fb:	53                   	push   %ebx
 4fc:	83 ec 24             	sub    $0x24,%esp
 4ff:	e8 58 02 00 00       	call   75c <__x86.get_pc_thunk.cx>
 504:	81 c1 bc 07 00 00    	add    $0x7bc,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 50a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 511:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 515:	74 17                	je     52e <printint+0x36>
 517:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 51b:	79 11                	jns    52e <printint+0x36>
    neg = 1;
 51d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 524:	8b 45 0c             	mov    0xc(%ebp),%eax
 527:	f7 d8                	neg    %eax
 529:	89 45 ec             	mov    %eax,-0x14(%ebp)
 52c:	eb 06                	jmp    534 <printint+0x3c>
  } else {
    x = xx;
 52e:	8b 45 0c             	mov    0xc(%ebp),%eax
 531:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 534:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 53b:	8b 5d 10             	mov    0x10(%ebp),%ebx
 53e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 541:	ba 00 00 00 00       	mov    $0x0,%edx
 546:	f7 f3                	div    %ebx
 548:	89 d3                	mov    %edx,%ebx
 54a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54d:	8d 50 01             	lea    0x1(%eax),%edx
 550:	89 55 f4             	mov    %edx,-0xc(%ebp)
 553:	0f b6 94 19 0c 00 00 	movzbl 0xc(%ecx,%ebx,1),%edx
 55a:	00 
 55b:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 55f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 562:	8b 45 ec             	mov    -0x14(%ebp),%eax
 565:	ba 00 00 00 00       	mov    $0x0,%edx
 56a:	f7 f3                	div    %ebx
 56c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 56f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 573:	75 c6                	jne    53b <printint+0x43>
  if(neg)
 575:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 579:	74 2d                	je     5a8 <printint+0xb0>
    buf[i++] = '-';
 57b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 57e:	8d 50 01             	lea    0x1(%eax),%edx
 581:	89 55 f4             	mov    %edx,-0xc(%ebp)
 584:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 589:	eb 1d                	jmp    5a8 <printint+0xb0>
    putc(fd, buf[i]);
 58b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 58e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 591:	01 d0                	add    %edx,%eax
 593:	0f b6 00             	movzbl (%eax),%eax
 596:	0f be c0             	movsbl %al,%eax
 599:	83 ec 08             	sub    $0x8,%esp
 59c:	50                   	push   %eax
 59d:	ff 75 08             	push   0x8(%ebp)
 5a0:	e8 20 ff ff ff       	call   4c5 <putc>
 5a5:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 5a8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5ac:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5b0:	79 d9                	jns    58b <printint+0x93>
}
 5b2:	90                   	nop
 5b3:	90                   	nop
 5b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5b7:	c9                   	leave  
 5b8:	c3                   	ret    

000005b9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5b9:	55                   	push   %ebp
 5ba:	89 e5                	mov    %esp,%ebp
 5bc:	53                   	push   %ebx
 5bd:	83 ec 24             	sub    $0x24,%esp
 5c0:	e8 8b fb ff ff       	call   150 <__x86.get_pc_thunk.bx>
 5c5:	81 c3 fb 06 00 00    	add    $0x6fb,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5d2:	8d 45 0c             	lea    0xc(%ebp),%eax
 5d5:	83 c0 04             	add    $0x4,%eax
 5d8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5db:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5e2:	e9 5b 01 00 00       	jmp    742 <printf+0x189>
    c = fmt[i] & 0xff;
 5e7:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5ed:	01 d0                	add    %edx,%eax
 5ef:	0f b6 00             	movzbl (%eax),%eax
 5f2:	0f be c0             	movsbl %al,%eax
 5f5:	25 ff 00 00 00       	and    $0xff,%eax
 5fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5fd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 601:	75 2c                	jne    62f <printf+0x76>
      if(c == '%'){
 603:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 607:	75 0c                	jne    615 <printf+0x5c>
        state = '%';
 609:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 610:	e9 29 01 00 00       	jmp    73e <printf+0x185>
      } else {
        putc(fd, c);
 615:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 618:	0f be c0             	movsbl %al,%eax
 61b:	83 ec 08             	sub    $0x8,%esp
 61e:	50                   	push   %eax
 61f:	ff 75 08             	push   0x8(%ebp)
 622:	e8 9e fe ff ff       	call   4c5 <putc>
 627:	83 c4 10             	add    $0x10,%esp
 62a:	e9 0f 01 00 00       	jmp    73e <printf+0x185>
      }
    } else if(state == '%'){
 62f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 633:	0f 85 05 01 00 00    	jne    73e <printf+0x185>
      if(c == 'd'){
 639:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 63d:	75 1e                	jne    65d <printf+0xa4>
        printint(fd, *ap, 10, 1);
 63f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 642:	8b 00                	mov    (%eax),%eax
 644:	6a 01                	push   $0x1
 646:	6a 0a                	push   $0xa
 648:	50                   	push   %eax
 649:	ff 75 08             	push   0x8(%ebp)
 64c:	e8 a7 fe ff ff       	call   4f8 <printint>
 651:	83 c4 10             	add    $0x10,%esp
        ap++;
 654:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 658:	e9 da 00 00 00       	jmp    737 <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 65d:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 661:	74 06                	je     669 <printf+0xb0>
 663:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 667:	75 1e                	jne    687 <printf+0xce>
        printint(fd, *ap, 16, 0);
 669:	8b 45 e8             	mov    -0x18(%ebp),%eax
 66c:	8b 00                	mov    (%eax),%eax
 66e:	6a 00                	push   $0x0
 670:	6a 10                	push   $0x10
 672:	50                   	push   %eax
 673:	ff 75 08             	push   0x8(%ebp)
 676:	e8 7d fe ff ff       	call   4f8 <printint>
 67b:	83 c4 10             	add    $0x10,%esp
        ap++;
 67e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 682:	e9 b0 00 00 00       	jmp    737 <printf+0x17e>
      } else if(c == 's'){
 687:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 68b:	75 45                	jne    6d2 <printf+0x119>
        s = (char*)*ap;
 68d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 690:	8b 00                	mov    (%eax),%eax
 692:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 695:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 699:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 69d:	75 27                	jne    6c6 <printf+0x10d>
          s = "(null)";
 69f:	8d 83 30 fd ff ff    	lea    -0x2d0(%ebx),%eax
 6a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 6a8:	eb 1c                	jmp    6c6 <printf+0x10d>
          putc(fd, *s);
 6aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ad:	0f b6 00             	movzbl (%eax),%eax
 6b0:	0f be c0             	movsbl %al,%eax
 6b3:	83 ec 08             	sub    $0x8,%esp
 6b6:	50                   	push   %eax
 6b7:	ff 75 08             	push   0x8(%ebp)
 6ba:	e8 06 fe ff ff       	call   4c5 <putc>
 6bf:	83 c4 10             	add    $0x10,%esp
          s++;
 6c2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 6c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c9:	0f b6 00             	movzbl (%eax),%eax
 6cc:	84 c0                	test   %al,%al
 6ce:	75 da                	jne    6aa <printf+0xf1>
 6d0:	eb 65                	jmp    737 <printf+0x17e>
        }
      } else if(c == 'c'){
 6d2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6d6:	75 1d                	jne    6f5 <printf+0x13c>
        putc(fd, *ap);
 6d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6db:	8b 00                	mov    (%eax),%eax
 6dd:	0f be c0             	movsbl %al,%eax
 6e0:	83 ec 08             	sub    $0x8,%esp
 6e3:	50                   	push   %eax
 6e4:	ff 75 08             	push   0x8(%ebp)
 6e7:	e8 d9 fd ff ff       	call   4c5 <putc>
 6ec:	83 c4 10             	add    $0x10,%esp
        ap++;
 6ef:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6f3:	eb 42                	jmp    737 <printf+0x17e>
      } else if(c == '%'){
 6f5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6f9:	75 17                	jne    712 <printf+0x159>
        putc(fd, c);
 6fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6fe:	0f be c0             	movsbl %al,%eax
 701:	83 ec 08             	sub    $0x8,%esp
 704:	50                   	push   %eax
 705:	ff 75 08             	push   0x8(%ebp)
 708:	e8 b8 fd ff ff       	call   4c5 <putc>
 70d:	83 c4 10             	add    $0x10,%esp
 710:	eb 25                	jmp    737 <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 712:	83 ec 08             	sub    $0x8,%esp
 715:	6a 25                	push   $0x25
 717:	ff 75 08             	push   0x8(%ebp)
 71a:	e8 a6 fd ff ff       	call   4c5 <putc>
 71f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 722:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 725:	0f be c0             	movsbl %al,%eax
 728:	83 ec 08             	sub    $0x8,%esp
 72b:	50                   	push   %eax
 72c:	ff 75 08             	push   0x8(%ebp)
 72f:	e8 91 fd ff ff       	call   4c5 <putc>
 734:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 737:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 73e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 742:	8b 55 0c             	mov    0xc(%ebp),%edx
 745:	8b 45 f0             	mov    -0x10(%ebp),%eax
 748:	01 d0                	add    %edx,%eax
 74a:	0f b6 00             	movzbl (%eax),%eax
 74d:	84 c0                	test   %al,%al
 74f:	0f 85 92 fe ff ff    	jne    5e7 <printf+0x2e>
    }
  }
}
 755:	90                   	nop
 756:	90                   	nop
 757:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 75a:	c9                   	leave  
 75b:	c3                   	ret    

0000075c <__x86.get_pc_thunk.cx>:
 75c:	8b 0c 24             	mov    (%esp),%ecx
 75f:	c3                   	ret    

00000760 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	83 ec 10             	sub    $0x10,%esp
 766:	e8 a6 fc ff ff       	call   411 <__x86.get_pc_thunk.ax>
 76b:	05 55 05 00 00       	add    $0x555,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 770:	8b 55 08             	mov    0x8(%ebp),%edx
 773:	83 ea 08             	sub    $0x8,%edx
 776:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 779:	8b 90 28 02 00 00    	mov    0x228(%eax),%edx
 77f:	89 55 fc             	mov    %edx,-0x4(%ebp)
 782:	eb 24                	jmp    7a8 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 784:	8b 55 fc             	mov    -0x4(%ebp),%edx
 787:	8b 12                	mov    (%edx),%edx
 789:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 78c:	72 12                	jb     7a0 <free+0x40>
 78e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 791:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 794:	77 24                	ja     7ba <free+0x5a>
 796:	8b 55 fc             	mov    -0x4(%ebp),%edx
 799:	8b 12                	mov    (%edx),%edx
 79b:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 79e:	72 1a                	jb     7ba <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7a3:	8b 12                	mov    (%edx),%edx
 7a5:	89 55 fc             	mov    %edx,-0x4(%ebp)
 7a8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7ab:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 7ae:	76 d4                	jbe    784 <free+0x24>
 7b0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7b3:	8b 12                	mov    (%edx),%edx
 7b5:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 7b8:	73 ca                	jae    784 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ba:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7bd:	8b 52 04             	mov    0x4(%edx),%edx
 7c0:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 7c7:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7ca:	01 d1                	add    %edx,%ecx
 7cc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7cf:	8b 12                	mov    (%edx),%edx
 7d1:	39 d1                	cmp    %edx,%ecx
 7d3:	75 24                	jne    7f9 <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 7d5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7d8:	8b 4a 04             	mov    0x4(%edx),%ecx
 7db:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7de:	8b 12                	mov    (%edx),%edx
 7e0:	8b 52 04             	mov    0x4(%edx),%edx
 7e3:	01 d1                	add    %edx,%ecx
 7e5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7e8:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7ee:	8b 12                	mov    (%edx),%edx
 7f0:	8b 0a                	mov    (%edx),%ecx
 7f2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7f5:	89 0a                	mov    %ecx,(%edx)
 7f7:	eb 0a                	jmp    803 <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 7f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7fc:	8b 0a                	mov    (%edx),%ecx
 7fe:	8b 55 f8             	mov    -0x8(%ebp),%edx
 801:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 803:	8b 55 fc             	mov    -0x4(%ebp),%edx
 806:	8b 52 04             	mov    0x4(%edx),%edx
 809:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 810:	8b 55 fc             	mov    -0x4(%ebp),%edx
 813:	01 ca                	add    %ecx,%edx
 815:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 818:	75 20                	jne    83a <free+0xda>
    p->s.size += bp->s.size;
 81a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 81d:	8b 4a 04             	mov    0x4(%edx),%ecx
 820:	8b 55 f8             	mov    -0x8(%ebp),%edx
 823:	8b 52 04             	mov    0x4(%edx),%edx
 826:	01 d1                	add    %edx,%ecx
 828:	8b 55 fc             	mov    -0x4(%ebp),%edx
 82b:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 82e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 831:	8b 0a                	mov    (%edx),%ecx
 833:	8b 55 fc             	mov    -0x4(%ebp),%edx
 836:	89 0a                	mov    %ecx,(%edx)
 838:	eb 08                	jmp    842 <free+0xe2>
  } else
    p->s.ptr = bp;
 83a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 83d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 840:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 842:	8b 55 fc             	mov    -0x4(%ebp),%edx
 845:	89 90 28 02 00 00    	mov    %edx,0x228(%eax)
}
 84b:	90                   	nop
 84c:	c9                   	leave  
 84d:	c3                   	ret    

0000084e <morecore>:

static Header*
morecore(uint nu)
{
 84e:	55                   	push   %ebp
 84f:	89 e5                	mov    %esp,%ebp
 851:	53                   	push   %ebx
 852:	83 ec 14             	sub    $0x14,%esp
 855:	e8 f6 f8 ff ff       	call   150 <__x86.get_pc_thunk.bx>
 85a:	81 c3 66 04 00 00    	add    $0x466,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 860:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 867:	77 07                	ja     870 <morecore+0x22>
    nu = 4096;
 869:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 870:	8b 45 08             	mov    0x8(%ebp),%eax
 873:	c1 e0 03             	shl    $0x3,%eax
 876:	83 ec 0c             	sub    $0xc,%esp
 879:	50                   	push   %eax
 87a:	e8 26 fc ff ff       	call   4a5 <sbrk>
 87f:	83 c4 10             	add    $0x10,%esp
 882:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 885:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 889:	75 07                	jne    892 <morecore+0x44>
    return 0;
 88b:	b8 00 00 00 00       	mov    $0x0,%eax
 890:	eb 27                	jmp    8b9 <morecore+0x6b>
  hp = (Header*)p;
 892:	8b 45 f4             	mov    -0xc(%ebp),%eax
 895:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 898:	8b 45 f0             	mov    -0x10(%ebp),%eax
 89b:	8b 55 08             	mov    0x8(%ebp),%edx
 89e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a4:	83 c0 08             	add    $0x8,%eax
 8a7:	83 ec 0c             	sub    $0xc,%esp
 8aa:	50                   	push   %eax
 8ab:	e8 b0 fe ff ff       	call   760 <free>
 8b0:	83 c4 10             	add    $0x10,%esp
  return freep;
 8b3:	8b 83 28 02 00 00    	mov    0x228(%ebx),%eax
}
 8b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8bc:	c9                   	leave  
 8bd:	c3                   	ret    

000008be <malloc>:

void*
malloc(uint nbytes)
{
 8be:	55                   	push   %ebp
 8bf:	89 e5                	mov    %esp,%ebp
 8c1:	53                   	push   %ebx
 8c2:	83 ec 14             	sub    $0x14,%esp
 8c5:	e8 86 f8 ff ff       	call   150 <__x86.get_pc_thunk.bx>
 8ca:	81 c3 f6 03 00 00    	add    $0x3f6,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d0:	8b 45 08             	mov    0x8(%ebp),%eax
 8d3:	83 c0 07             	add    $0x7,%eax
 8d6:	c1 e8 03             	shr    $0x3,%eax
 8d9:	83 c0 01             	add    $0x1,%eax
 8dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8df:	8b 83 28 02 00 00    	mov    0x228(%ebx),%eax
 8e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8e8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8ec:	75 28                	jne    916 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 8ee:	8d 83 20 02 00 00    	lea    0x220(%ebx),%eax
 8f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8fa:	89 83 28 02 00 00    	mov    %eax,0x228(%ebx)
 900:	8b 83 28 02 00 00    	mov    0x228(%ebx),%eax
 906:	89 83 20 02 00 00    	mov    %eax,0x220(%ebx)
    base.s.size = 0;
 90c:	c7 83 24 02 00 00 00 	movl   $0x0,0x224(%ebx)
 913:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 916:	8b 45 f0             	mov    -0x10(%ebp),%eax
 919:	8b 00                	mov    (%eax),%eax
 91b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 91e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 921:	8b 40 04             	mov    0x4(%eax),%eax
 924:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 927:	77 4e                	ja     977 <malloc+0xb9>
      if(p->s.size == nunits)
 929:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92c:	8b 40 04             	mov    0x4(%eax),%eax
 92f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 932:	75 0c                	jne    940 <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 934:	8b 45 f4             	mov    -0xc(%ebp),%eax
 937:	8b 10                	mov    (%eax),%edx
 939:	8b 45 f0             	mov    -0x10(%ebp),%eax
 93c:	89 10                	mov    %edx,(%eax)
 93e:	eb 26                	jmp    966 <malloc+0xa8>
      else {
        p->s.size -= nunits;
 940:	8b 45 f4             	mov    -0xc(%ebp),%eax
 943:	8b 40 04             	mov    0x4(%eax),%eax
 946:	2b 45 ec             	sub    -0x14(%ebp),%eax
 949:	89 c2                	mov    %eax,%edx
 94b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 951:	8b 45 f4             	mov    -0xc(%ebp),%eax
 954:	8b 40 04             	mov    0x4(%eax),%eax
 957:	c1 e0 03             	shl    $0x3,%eax
 95a:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 95d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 960:	8b 55 ec             	mov    -0x14(%ebp),%edx
 963:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 966:	8b 45 f0             	mov    -0x10(%ebp),%eax
 969:	89 83 28 02 00 00    	mov    %eax,0x228(%ebx)
      return (void*)(p + 1);
 96f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 972:	83 c0 08             	add    $0x8,%eax
 975:	eb 3c                	jmp    9b3 <malloc+0xf5>
    }
    if(p == freep)
 977:	8b 83 28 02 00 00    	mov    0x228(%ebx),%eax
 97d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 980:	75 1e                	jne    9a0 <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 982:	83 ec 0c             	sub    $0xc,%esp
 985:	ff 75 ec             	push   -0x14(%ebp)
 988:	e8 c1 fe ff ff       	call   84e <morecore>
 98d:	83 c4 10             	add    $0x10,%esp
 990:	89 45 f4             	mov    %eax,-0xc(%ebp)
 993:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 997:	75 07                	jne    9a0 <malloc+0xe2>
        return 0;
 999:	b8 00 00 00 00       	mov    $0x0,%eax
 99e:	eb 13                	jmp    9b3 <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a9:	8b 00                	mov    (%eax),%eax
 9ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9ae:	e9 6b ff ff ff       	jmp    91e <malloc+0x60>
  }
}
 9b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 9b6:	c9                   	leave  
 9b7:	c3                   	ret    
