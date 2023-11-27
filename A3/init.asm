
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 10             	sub    $0x10,%esp
  12:	e8 08 01 00 00       	call   11f <__x86.get_pc_thunk.bx>
  17:	81 c3 69 0c 00 00    	add    $0xc69,%ebx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  1d:	83 ec 08             	sub    $0x8,%esp
  20:	6a 02                	push   $0x2
  22:	8d 83 0a fd ff ff    	lea    -0x2f6(%ebx),%eax
  28:	50                   	push   %eax
  29:	e8 fe 03 00 00       	call   42c <open>
  2e:	83 c4 10             	add    $0x10,%esp
  31:	85 c0                	test   %eax,%eax
  33:	79 2a                	jns    5f <main+0x5f>
    mknod("console", 1, 1);
  35:	83 ec 04             	sub    $0x4,%esp
  38:	6a 01                	push   $0x1
  3a:	6a 01                	push   $0x1
  3c:	8d 83 0a fd ff ff    	lea    -0x2f6(%ebx),%eax
  42:	50                   	push   %eax
  43:	e8 ec 03 00 00       	call   434 <mknod>
  48:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
  4b:	83 ec 08             	sub    $0x8,%esp
  4e:	6a 02                	push   $0x2
  50:	8d 83 0a fd ff ff    	lea    -0x2f6(%ebx),%eax
  56:	50                   	push   %eax
  57:	e8 d0 03 00 00       	call   42c <open>
  5c:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
  5f:	83 ec 0c             	sub    $0xc,%esp
  62:	6a 00                	push   $0x0
  64:	e8 fb 03 00 00       	call   464 <dup>
  69:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
  6c:	83 ec 0c             	sub    $0xc,%esp
  6f:	6a 00                	push   $0x0
  71:	e8 ee 03 00 00       	call   464 <dup>
  76:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  79:	83 ec 08             	sub    $0x8,%esp
  7c:	8d 83 12 fd ff ff    	lea    -0x2ee(%ebx),%eax
  82:	50                   	push   %eax
  83:	6a 01                	push   $0x1
  85:	e8 fe 04 00 00       	call   588 <printf>
  8a:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  8d:	e8 52 03 00 00       	call   3e4 <fork>
  92:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
  95:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  99:	79 19                	jns    b4 <main+0xb4>
      printf(1, "init: fork failed\n");
  9b:	83 ec 08             	sub    $0x8,%esp
  9e:	8d 83 25 fd ff ff    	lea    -0x2db(%ebx),%eax
  a4:	50                   	push   %eax
  a5:	6a 01                	push   $0x1
  a7:	e8 dc 04 00 00       	call   588 <printf>
  ac:	83 c4 10             	add    $0x10,%esp
      exit();
  af:	e8 38 03 00 00       	call   3ec <exit>
    }
    if(pid == 0){
  b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  b8:	75 46                	jne    100 <main+0x100>
      exec("sh", argv);
  ba:	83 ec 08             	sub    $0x8,%esp
  bd:	8d 83 0c 00 00 00    	lea    0xc(%ebx),%eax
  c3:	50                   	push   %eax
  c4:	8d 83 07 fd ff ff    	lea    -0x2f9(%ebx),%eax
  ca:	50                   	push   %eax
  cb:	e8 54 03 00 00       	call   424 <exec>
  d0:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
  d3:	83 ec 08             	sub    $0x8,%esp
  d6:	8d 83 38 fd ff ff    	lea    -0x2c8(%ebx),%eax
  dc:	50                   	push   %eax
  dd:	6a 01                	push   $0x1
  df:	e8 a4 04 00 00       	call   588 <printf>
  e4:	83 c4 10             	add    $0x10,%esp
      exit();
  e7:	e8 00 03 00 00       	call   3ec <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  ec:	83 ec 08             	sub    $0x8,%esp
  ef:	8d 83 4e fd ff ff    	lea    -0x2b2(%ebx),%eax
  f5:	50                   	push   %eax
  f6:	6a 01                	push   $0x1
  f8:	e8 8b 04 00 00       	call   588 <printf>
  fd:	83 c4 10             	add    $0x10,%esp
    while((wpid=wait()) >= 0 && wpid != pid)
 100:	e8 ef 02 00 00       	call   3f4 <wait>
 105:	89 45 f0             	mov    %eax,-0x10(%ebp)
 108:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 10c:	0f 88 67 ff ff ff    	js     79 <main+0x79>
 112:	8b 45 f0             	mov    -0x10(%ebp),%eax
 115:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 118:	75 d2                	jne    ec <main+0xec>
    printf(1, "init: starting sh\n");
 11a:	e9 5a ff ff ff       	jmp    79 <main+0x79>

0000011f <__x86.get_pc_thunk.bx>:
 11f:	8b 1c 24             	mov    (%esp),%ebx
 122:	c3                   	ret    

00000123 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 123:	55                   	push   %ebp
 124:	89 e5                	mov    %esp,%ebp
 126:	57                   	push   %edi
 127:	53                   	push   %ebx
 128:	e8 b3 02 00 00       	call   3e0 <__x86.get_pc_thunk.ax>
 12d:	05 53 0b 00 00       	add    $0xb53,%eax
  asm volatile("cld; rep stosb" :
 132:	8b 4d 08             	mov    0x8(%ebp),%ecx
 135:	8b 55 10             	mov    0x10(%ebp),%edx
 138:	8b 45 0c             	mov    0xc(%ebp),%eax
 13b:	89 cb                	mov    %ecx,%ebx
 13d:	89 df                	mov    %ebx,%edi
 13f:	89 d1                	mov    %edx,%ecx
 141:	fc                   	cld    
 142:	f3 aa                	rep stos %al,%es:(%edi)
 144:	89 ca                	mov    %ecx,%edx
 146:	89 fb                	mov    %edi,%ebx
 148:	89 5d 08             	mov    %ebx,0x8(%ebp)
 14b:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 14e:	90                   	nop
 14f:	5b                   	pop    %ebx
 150:	5f                   	pop    %edi
 151:	5d                   	pop    %ebp
 152:	c3                   	ret    

00000153 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 153:	55                   	push   %ebp
 154:	89 e5                	mov    %esp,%ebp
 156:	83 ec 10             	sub    $0x10,%esp
 159:	e8 82 02 00 00       	call   3e0 <__x86.get_pc_thunk.ax>
 15e:	05 22 0b 00 00       	add    $0xb22,%eax
  char *os;

  os = s;
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 169:	90                   	nop
 16a:	8b 55 0c             	mov    0xc(%ebp),%edx
 16d:	8d 42 01             	lea    0x1(%edx),%eax
 170:	89 45 0c             	mov    %eax,0xc(%ebp)
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	8d 48 01             	lea    0x1(%eax),%ecx
 179:	89 4d 08             	mov    %ecx,0x8(%ebp)
 17c:	0f b6 12             	movzbl (%edx),%edx
 17f:	88 10                	mov    %dl,(%eax)
 181:	0f b6 00             	movzbl (%eax),%eax
 184:	84 c0                	test   %al,%al
 186:	75 e2                	jne    16a <strcpy+0x17>
    ;
  return os;
 188:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 18b:	c9                   	leave  
 18c:	c3                   	ret    

0000018d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 18d:	55                   	push   %ebp
 18e:	89 e5                	mov    %esp,%ebp
 190:	e8 4b 02 00 00       	call   3e0 <__x86.get_pc_thunk.ax>
 195:	05 eb 0a 00 00       	add    $0xaeb,%eax
  while(*p && *p == *q)
 19a:	eb 08                	jmp    1a4 <strcmp+0x17>
    p++, q++;
 19c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1a0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	0f b6 00             	movzbl (%eax),%eax
 1aa:	84 c0                	test   %al,%al
 1ac:	74 10                	je     1be <strcmp+0x31>
 1ae:	8b 45 08             	mov    0x8(%ebp),%eax
 1b1:	0f b6 10             	movzbl (%eax),%edx
 1b4:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b7:	0f b6 00             	movzbl (%eax),%eax
 1ba:	38 c2                	cmp    %al,%dl
 1bc:	74 de                	je     19c <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
 1be:	8b 45 08             	mov    0x8(%ebp),%eax
 1c1:	0f b6 00             	movzbl (%eax),%eax
 1c4:	0f b6 d0             	movzbl %al,%edx
 1c7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ca:	0f b6 00             	movzbl (%eax),%eax
 1cd:	0f b6 c8             	movzbl %al,%ecx
 1d0:	89 d0                	mov    %edx,%eax
 1d2:	29 c8                	sub    %ecx,%eax
}
 1d4:	5d                   	pop    %ebp
 1d5:	c3                   	ret    

000001d6 <strlen>:

uint
strlen(const char *s)
{
 1d6:	55                   	push   %ebp
 1d7:	89 e5                	mov    %esp,%ebp
 1d9:	83 ec 10             	sub    $0x10,%esp
 1dc:	e8 ff 01 00 00       	call   3e0 <__x86.get_pc_thunk.ax>
 1e1:	05 9f 0a 00 00       	add    $0xa9f,%eax
  int n;

  for(n = 0; s[n]; n++)
 1e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1ed:	eb 04                	jmp    1f3 <strlen+0x1d>
 1ef:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1f3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1f6:	8b 45 08             	mov    0x8(%ebp),%eax
 1f9:	01 d0                	add    %edx,%eax
 1fb:	0f b6 00             	movzbl (%eax),%eax
 1fe:	84 c0                	test   %al,%al
 200:	75 ed                	jne    1ef <strlen+0x19>
    ;
  return n;
 202:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 205:	c9                   	leave  
 206:	c3                   	ret    

00000207 <memset>:

void*
memset(void *dst, int c, uint n)
{
 207:	55                   	push   %ebp
 208:	89 e5                	mov    %esp,%ebp
 20a:	e8 d1 01 00 00       	call   3e0 <__x86.get_pc_thunk.ax>
 20f:	05 71 0a 00 00       	add    $0xa71,%eax
  stosb(dst, c, n);
 214:	8b 45 10             	mov    0x10(%ebp),%eax
 217:	50                   	push   %eax
 218:	ff 75 0c             	push   0xc(%ebp)
 21b:	ff 75 08             	push   0x8(%ebp)
 21e:	e8 00 ff ff ff       	call   123 <stosb>
 223:	83 c4 0c             	add    $0xc,%esp
  return dst;
 226:	8b 45 08             	mov    0x8(%ebp),%eax
}
 229:	c9                   	leave  
 22a:	c3                   	ret    

0000022b <strchr>:

char*
strchr(const char *s, char c)
{
 22b:	55                   	push   %ebp
 22c:	89 e5                	mov    %esp,%ebp
 22e:	83 ec 04             	sub    $0x4,%esp
 231:	e8 aa 01 00 00       	call   3e0 <__x86.get_pc_thunk.ax>
 236:	05 4a 0a 00 00       	add    $0xa4a,%eax
 23b:	8b 45 0c             	mov    0xc(%ebp),%eax
 23e:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 241:	eb 14                	jmp    257 <strchr+0x2c>
    if(*s == c)
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	0f b6 00             	movzbl (%eax),%eax
 249:	38 45 fc             	cmp    %al,-0x4(%ebp)
 24c:	75 05                	jne    253 <strchr+0x28>
      return (char*)s;
 24e:	8b 45 08             	mov    0x8(%ebp),%eax
 251:	eb 13                	jmp    266 <strchr+0x3b>
  for(; *s; s++)
 253:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	0f b6 00             	movzbl (%eax),%eax
 25d:	84 c0                	test   %al,%al
 25f:	75 e2                	jne    243 <strchr+0x18>
  return 0;
 261:	b8 00 00 00 00       	mov    $0x0,%eax
}
 266:	c9                   	leave  
 267:	c3                   	ret    

00000268 <gets>:

char*
gets(char *buf, int max)
{
 268:	55                   	push   %ebp
 269:	89 e5                	mov    %esp,%ebp
 26b:	53                   	push   %ebx
 26c:	83 ec 14             	sub    $0x14,%esp
 26f:	e8 ab fe ff ff       	call   11f <__x86.get_pc_thunk.bx>
 274:	81 c3 0c 0a 00 00    	add    $0xa0c,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 281:	eb 42                	jmp    2c5 <gets+0x5d>
    cc = read(0, &c, 1);
 283:	83 ec 04             	sub    $0x4,%esp
 286:	6a 01                	push   $0x1
 288:	8d 45 ef             	lea    -0x11(%ebp),%eax
 28b:	50                   	push   %eax
 28c:	6a 00                	push   $0x0
 28e:	e8 71 01 00 00       	call   404 <read>
 293:	83 c4 10             	add    $0x10,%esp
 296:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 299:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 29d:	7e 33                	jle    2d2 <gets+0x6a>
      break;
    buf[i++] = c;
 29f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2a2:	8d 50 01             	lea    0x1(%eax),%edx
 2a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2a8:	89 c2                	mov    %eax,%edx
 2aa:	8b 45 08             	mov    0x8(%ebp),%eax
 2ad:	01 c2                	add    %eax,%edx
 2af:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2b3:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2b5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2b9:	3c 0a                	cmp    $0xa,%al
 2bb:	74 16                	je     2d3 <gets+0x6b>
 2bd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2c1:	3c 0d                	cmp    $0xd,%al
 2c3:	74 0e                	je     2d3 <gets+0x6b>
  for(i=0; i+1 < max; ){
 2c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2c8:	83 c0 01             	add    $0x1,%eax
 2cb:	39 45 0c             	cmp    %eax,0xc(%ebp)
 2ce:	7f b3                	jg     283 <gets+0x1b>
 2d0:	eb 01                	jmp    2d3 <gets+0x6b>
      break;
 2d2:	90                   	nop
      break;
  }
  buf[i] = '\0';
 2d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2d6:	8b 45 08             	mov    0x8(%ebp),%eax
 2d9:	01 d0                	add    %edx,%eax
 2db:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2de:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2e4:	c9                   	leave  
 2e5:	c3                   	ret    

000002e6 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e6:	55                   	push   %ebp
 2e7:	89 e5                	mov    %esp,%ebp
 2e9:	53                   	push   %ebx
 2ea:	83 ec 14             	sub    $0x14,%esp
 2ed:	e8 2d fe ff ff       	call   11f <__x86.get_pc_thunk.bx>
 2f2:	81 c3 8e 09 00 00    	add    $0x98e,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f8:	83 ec 08             	sub    $0x8,%esp
 2fb:	6a 00                	push   $0x0
 2fd:	ff 75 08             	push   0x8(%ebp)
 300:	e8 27 01 00 00       	call   42c <open>
 305:	83 c4 10             	add    $0x10,%esp
 308:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 30b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 30f:	79 07                	jns    318 <stat+0x32>
    return -1;
 311:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 316:	eb 25                	jmp    33d <stat+0x57>
  r = fstat(fd, st);
 318:	83 ec 08             	sub    $0x8,%esp
 31b:	ff 75 0c             	push   0xc(%ebp)
 31e:	ff 75 f4             	push   -0xc(%ebp)
 321:	e8 1e 01 00 00       	call   444 <fstat>
 326:	83 c4 10             	add    $0x10,%esp
 329:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 32c:	83 ec 0c             	sub    $0xc,%esp
 32f:	ff 75 f4             	push   -0xc(%ebp)
 332:	e8 dd 00 00 00       	call   414 <close>
 337:	83 c4 10             	add    $0x10,%esp
  return r;
 33a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 33d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 340:	c9                   	leave  
 341:	c3                   	ret    

00000342 <atoi>:

int
atoi(const char *s)
{
 342:	55                   	push   %ebp
 343:	89 e5                	mov    %esp,%ebp
 345:	83 ec 10             	sub    $0x10,%esp
 348:	e8 93 00 00 00       	call   3e0 <__x86.get_pc_thunk.ax>
 34d:	05 33 09 00 00       	add    $0x933,%eax
  int n;

  n = 0;
 352:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 359:	eb 25                	jmp    380 <atoi+0x3e>
    n = n*10 + *s++ - '0';
 35b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 35e:	89 d0                	mov    %edx,%eax
 360:	c1 e0 02             	shl    $0x2,%eax
 363:	01 d0                	add    %edx,%eax
 365:	01 c0                	add    %eax,%eax
 367:	89 c1                	mov    %eax,%ecx
 369:	8b 45 08             	mov    0x8(%ebp),%eax
 36c:	8d 50 01             	lea    0x1(%eax),%edx
 36f:	89 55 08             	mov    %edx,0x8(%ebp)
 372:	0f b6 00             	movzbl (%eax),%eax
 375:	0f be c0             	movsbl %al,%eax
 378:	01 c8                	add    %ecx,%eax
 37a:	83 e8 30             	sub    $0x30,%eax
 37d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 380:	8b 45 08             	mov    0x8(%ebp),%eax
 383:	0f b6 00             	movzbl (%eax),%eax
 386:	3c 2f                	cmp    $0x2f,%al
 388:	7e 0a                	jle    394 <atoi+0x52>
 38a:	8b 45 08             	mov    0x8(%ebp),%eax
 38d:	0f b6 00             	movzbl (%eax),%eax
 390:	3c 39                	cmp    $0x39,%al
 392:	7e c7                	jle    35b <atoi+0x19>
  return n;
 394:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 397:	c9                   	leave  
 398:	c3                   	ret    

00000399 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 399:	55                   	push   %ebp
 39a:	89 e5                	mov    %esp,%ebp
 39c:	83 ec 10             	sub    $0x10,%esp
 39f:	e8 3c 00 00 00       	call   3e0 <__x86.get_pc_thunk.ax>
 3a4:	05 dc 08 00 00       	add    $0x8dc,%eax
  char *dst;
  const char *src;

  dst = vdst;
 3a9:	8b 45 08             	mov    0x8(%ebp),%eax
 3ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3af:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3b5:	eb 17                	jmp    3ce <memmove+0x35>
    *dst++ = *src++;
 3b7:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3ba:	8d 42 01             	lea    0x1(%edx),%eax
 3bd:	89 45 f8             	mov    %eax,-0x8(%ebp)
 3c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3c3:	8d 48 01             	lea    0x1(%eax),%ecx
 3c6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 3c9:	0f b6 12             	movzbl (%edx),%edx
 3cc:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 3ce:	8b 45 10             	mov    0x10(%ebp),%eax
 3d1:	8d 50 ff             	lea    -0x1(%eax),%edx
 3d4:	89 55 10             	mov    %edx,0x10(%ebp)
 3d7:	85 c0                	test   %eax,%eax
 3d9:	7f dc                	jg     3b7 <memmove+0x1e>
  return vdst;
 3db:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3de:	c9                   	leave  
 3df:	c3                   	ret    

000003e0 <__x86.get_pc_thunk.ax>:
 3e0:	8b 04 24             	mov    (%esp),%eax
 3e3:	c3                   	ret    

000003e4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3e4:	b8 01 00 00 00       	mov    $0x1,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <exit>:
SYSCALL(exit)
 3ec:	b8 02 00 00 00       	mov    $0x2,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <wait>:
SYSCALL(wait)
 3f4:	b8 03 00 00 00       	mov    $0x3,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <pipe>:
SYSCALL(pipe)
 3fc:	b8 04 00 00 00       	mov    $0x4,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <read>:
SYSCALL(read)
 404:	b8 05 00 00 00       	mov    $0x5,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <write>:
SYSCALL(write)
 40c:	b8 10 00 00 00       	mov    $0x10,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <close>:
SYSCALL(close)
 414:	b8 15 00 00 00       	mov    $0x15,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <kill>:
SYSCALL(kill)
 41c:	b8 06 00 00 00       	mov    $0x6,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <exec>:
SYSCALL(exec)
 424:	b8 07 00 00 00       	mov    $0x7,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <open>:
SYSCALL(open)
 42c:	b8 0f 00 00 00       	mov    $0xf,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <mknod>:
SYSCALL(mknod)
 434:	b8 11 00 00 00       	mov    $0x11,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <unlink>:
SYSCALL(unlink)
 43c:	b8 12 00 00 00       	mov    $0x12,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <fstat>:
SYSCALL(fstat)
 444:	b8 08 00 00 00       	mov    $0x8,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <link>:
SYSCALL(link)
 44c:	b8 13 00 00 00       	mov    $0x13,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <mkdir>:
SYSCALL(mkdir)
 454:	b8 14 00 00 00       	mov    $0x14,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <chdir>:
SYSCALL(chdir)
 45c:	b8 09 00 00 00       	mov    $0x9,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <dup>:
SYSCALL(dup)
 464:	b8 0a 00 00 00       	mov    $0xa,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <getpid>:
SYSCALL(getpid)
 46c:	b8 0b 00 00 00       	mov    $0xb,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <sbrk>:
SYSCALL(sbrk)
 474:	b8 0c 00 00 00       	mov    $0xc,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    

0000047c <sleep>:
SYSCALL(sleep)
 47c:	b8 0d 00 00 00       	mov    $0xd,%eax
 481:	cd 40                	int    $0x40
 483:	c3                   	ret    

00000484 <uptime>:
SYSCALL(uptime)
 484:	b8 0e 00 00 00       	mov    $0xe,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <random>:
SYSCALL(random)
 48c:	b8 16 00 00 00       	mov    $0x16,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 494:	55                   	push   %ebp
 495:	89 e5                	mov    %esp,%ebp
 497:	53                   	push   %ebx
 498:	83 ec 14             	sub    $0x14,%esp
 49b:	e8 40 ff ff ff       	call   3e0 <__x86.get_pc_thunk.ax>
 4a0:	05 e0 07 00 00       	add    $0x7e0,%eax
 4a5:	8b 55 0c             	mov    0xc(%ebp),%edx
 4a8:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 4ab:	83 ec 04             	sub    $0x4,%esp
 4ae:	6a 01                	push   $0x1
 4b0:	8d 55 f4             	lea    -0xc(%ebp),%edx
 4b3:	52                   	push   %edx
 4b4:	ff 75 08             	push   0x8(%ebp)
 4b7:	89 c3                	mov    %eax,%ebx
 4b9:	e8 4e ff ff ff       	call   40c <write>
 4be:	83 c4 10             	add    $0x10,%esp
}
 4c1:	90                   	nop
 4c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4c5:	c9                   	leave  
 4c6:	c3                   	ret    

000004c7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4c7:	55                   	push   %ebp
 4c8:	89 e5                	mov    %esp,%ebp
 4ca:	53                   	push   %ebx
 4cb:	83 ec 24             	sub    $0x24,%esp
 4ce:	e8 58 02 00 00       	call   72b <__x86.get_pc_thunk.cx>
 4d3:	81 c1 ad 07 00 00    	add    $0x7ad,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4d9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4e0:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4e4:	74 17                	je     4fd <printint+0x36>
 4e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4ea:	79 11                	jns    4fd <printint+0x36>
    neg = 1;
 4ec:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4f3:	8b 45 0c             	mov    0xc(%ebp),%eax
 4f6:	f7 d8                	neg    %eax
 4f8:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4fb:	eb 06                	jmp    503 <printint+0x3c>
  } else {
    x = xx;
 4fd:	8b 45 0c             	mov    0xc(%ebp),%eax
 500:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 503:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 50a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 50d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 510:	ba 00 00 00 00       	mov    $0x0,%edx
 515:	f7 f3                	div    %ebx
 517:	89 d3                	mov    %edx,%ebx
 519:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51c:	8d 50 01             	lea    0x1(%eax),%edx
 51f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 522:	0f b6 94 19 14 00 00 	movzbl 0x14(%ecx,%ebx,1),%edx
 529:	00 
 52a:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 52e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 531:	8b 45 ec             	mov    -0x14(%ebp),%eax
 534:	ba 00 00 00 00       	mov    $0x0,%edx
 539:	f7 f3                	div    %ebx
 53b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 53e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 542:	75 c6                	jne    50a <printint+0x43>
  if(neg)
 544:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 548:	74 2d                	je     577 <printint+0xb0>
    buf[i++] = '-';
 54a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54d:	8d 50 01             	lea    0x1(%eax),%edx
 550:	89 55 f4             	mov    %edx,-0xc(%ebp)
 553:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 558:	eb 1d                	jmp    577 <printint+0xb0>
    putc(fd, buf[i]);
 55a:	8d 55 dc             	lea    -0x24(%ebp),%edx
 55d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 560:	01 d0                	add    %edx,%eax
 562:	0f b6 00             	movzbl (%eax),%eax
 565:	0f be c0             	movsbl %al,%eax
 568:	83 ec 08             	sub    $0x8,%esp
 56b:	50                   	push   %eax
 56c:	ff 75 08             	push   0x8(%ebp)
 56f:	e8 20 ff ff ff       	call   494 <putc>
 574:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 577:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 57b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 57f:	79 d9                	jns    55a <printint+0x93>
}
 581:	90                   	nop
 582:	90                   	nop
 583:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 586:	c9                   	leave  
 587:	c3                   	ret    

00000588 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 588:	55                   	push   %ebp
 589:	89 e5                	mov    %esp,%ebp
 58b:	53                   	push   %ebx
 58c:	83 ec 24             	sub    $0x24,%esp
 58f:	e8 8b fb ff ff       	call   11f <__x86.get_pc_thunk.bx>
 594:	81 c3 ec 06 00 00    	add    $0x6ec,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 59a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5a1:	8d 45 0c             	lea    0xc(%ebp),%eax
 5a4:	83 c0 04             	add    $0x4,%eax
 5a7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5aa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5b1:	e9 5b 01 00 00       	jmp    711 <printf+0x189>
    c = fmt[i] & 0xff;
 5b6:	8b 55 0c             	mov    0xc(%ebp),%edx
 5b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5bc:	01 d0                	add    %edx,%eax
 5be:	0f b6 00             	movzbl (%eax),%eax
 5c1:	0f be c0             	movsbl %al,%eax
 5c4:	25 ff 00 00 00       	and    $0xff,%eax
 5c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5d0:	75 2c                	jne    5fe <printf+0x76>
      if(c == '%'){
 5d2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5d6:	75 0c                	jne    5e4 <printf+0x5c>
        state = '%';
 5d8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5df:	e9 29 01 00 00       	jmp    70d <printf+0x185>
      } else {
        putc(fd, c);
 5e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e7:	0f be c0             	movsbl %al,%eax
 5ea:	83 ec 08             	sub    $0x8,%esp
 5ed:	50                   	push   %eax
 5ee:	ff 75 08             	push   0x8(%ebp)
 5f1:	e8 9e fe ff ff       	call   494 <putc>
 5f6:	83 c4 10             	add    $0x10,%esp
 5f9:	e9 0f 01 00 00       	jmp    70d <printf+0x185>
      }
    } else if(state == '%'){
 5fe:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 602:	0f 85 05 01 00 00    	jne    70d <printf+0x185>
      if(c == 'd'){
 608:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 60c:	75 1e                	jne    62c <printf+0xa4>
        printint(fd, *ap, 10, 1);
 60e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 611:	8b 00                	mov    (%eax),%eax
 613:	6a 01                	push   $0x1
 615:	6a 0a                	push   $0xa
 617:	50                   	push   %eax
 618:	ff 75 08             	push   0x8(%ebp)
 61b:	e8 a7 fe ff ff       	call   4c7 <printint>
 620:	83 c4 10             	add    $0x10,%esp
        ap++;
 623:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 627:	e9 da 00 00 00       	jmp    706 <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 62c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 630:	74 06                	je     638 <printf+0xb0>
 632:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 636:	75 1e                	jne    656 <printf+0xce>
        printint(fd, *ap, 16, 0);
 638:	8b 45 e8             	mov    -0x18(%ebp),%eax
 63b:	8b 00                	mov    (%eax),%eax
 63d:	6a 00                	push   $0x0
 63f:	6a 10                	push   $0x10
 641:	50                   	push   %eax
 642:	ff 75 08             	push   0x8(%ebp)
 645:	e8 7d fe ff ff       	call   4c7 <printint>
 64a:	83 c4 10             	add    $0x10,%esp
        ap++;
 64d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 651:	e9 b0 00 00 00       	jmp    706 <printf+0x17e>
      } else if(c == 's'){
 656:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 65a:	75 45                	jne    6a1 <printf+0x119>
        s = (char*)*ap;
 65c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 65f:	8b 00                	mov    (%eax),%eax
 661:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 664:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 668:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 66c:	75 27                	jne    695 <printf+0x10d>
          s = "(null)";
 66e:	8d 83 57 fd ff ff    	lea    -0x2a9(%ebx),%eax
 674:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 677:	eb 1c                	jmp    695 <printf+0x10d>
          putc(fd, *s);
 679:	8b 45 f4             	mov    -0xc(%ebp),%eax
 67c:	0f b6 00             	movzbl (%eax),%eax
 67f:	0f be c0             	movsbl %al,%eax
 682:	83 ec 08             	sub    $0x8,%esp
 685:	50                   	push   %eax
 686:	ff 75 08             	push   0x8(%ebp)
 689:	e8 06 fe ff ff       	call   494 <putc>
 68e:	83 c4 10             	add    $0x10,%esp
          s++;
 691:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 695:	8b 45 f4             	mov    -0xc(%ebp),%eax
 698:	0f b6 00             	movzbl (%eax),%eax
 69b:	84 c0                	test   %al,%al
 69d:	75 da                	jne    679 <printf+0xf1>
 69f:	eb 65                	jmp    706 <printf+0x17e>
        }
      } else if(c == 'c'){
 6a1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6a5:	75 1d                	jne    6c4 <printf+0x13c>
        putc(fd, *ap);
 6a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6aa:	8b 00                	mov    (%eax),%eax
 6ac:	0f be c0             	movsbl %al,%eax
 6af:	83 ec 08             	sub    $0x8,%esp
 6b2:	50                   	push   %eax
 6b3:	ff 75 08             	push   0x8(%ebp)
 6b6:	e8 d9 fd ff ff       	call   494 <putc>
 6bb:	83 c4 10             	add    $0x10,%esp
        ap++;
 6be:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6c2:	eb 42                	jmp    706 <printf+0x17e>
      } else if(c == '%'){
 6c4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6c8:	75 17                	jne    6e1 <printf+0x159>
        putc(fd, c);
 6ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6cd:	0f be c0             	movsbl %al,%eax
 6d0:	83 ec 08             	sub    $0x8,%esp
 6d3:	50                   	push   %eax
 6d4:	ff 75 08             	push   0x8(%ebp)
 6d7:	e8 b8 fd ff ff       	call   494 <putc>
 6dc:	83 c4 10             	add    $0x10,%esp
 6df:	eb 25                	jmp    706 <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6e1:	83 ec 08             	sub    $0x8,%esp
 6e4:	6a 25                	push   $0x25
 6e6:	ff 75 08             	push   0x8(%ebp)
 6e9:	e8 a6 fd ff ff       	call   494 <putc>
 6ee:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6f4:	0f be c0             	movsbl %al,%eax
 6f7:	83 ec 08             	sub    $0x8,%esp
 6fa:	50                   	push   %eax
 6fb:	ff 75 08             	push   0x8(%ebp)
 6fe:	e8 91 fd ff ff       	call   494 <putc>
 703:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 706:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 70d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 711:	8b 55 0c             	mov    0xc(%ebp),%edx
 714:	8b 45 f0             	mov    -0x10(%ebp),%eax
 717:	01 d0                	add    %edx,%eax
 719:	0f b6 00             	movzbl (%eax),%eax
 71c:	84 c0                	test   %al,%al
 71e:	0f 85 92 fe ff ff    	jne    5b6 <printf+0x2e>
    }
  }
}
 724:	90                   	nop
 725:	90                   	nop
 726:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 729:	c9                   	leave  
 72a:	c3                   	ret    

0000072b <__x86.get_pc_thunk.cx>:
 72b:	8b 0c 24             	mov    (%esp),%ecx
 72e:	c3                   	ret    

0000072f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 72f:	55                   	push   %ebp
 730:	89 e5                	mov    %esp,%ebp
 732:	83 ec 10             	sub    $0x10,%esp
 735:	e8 a6 fc ff ff       	call   3e0 <__x86.get_pc_thunk.ax>
 73a:	05 46 05 00 00       	add    $0x546,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 73f:	8b 55 08             	mov    0x8(%ebp),%edx
 742:	83 ea 08             	sub    $0x8,%edx
 745:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 748:	8b 90 30 00 00 00    	mov    0x30(%eax),%edx
 74e:	89 55 fc             	mov    %edx,-0x4(%ebp)
 751:	eb 24                	jmp    777 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 753:	8b 55 fc             	mov    -0x4(%ebp),%edx
 756:	8b 12                	mov    (%edx),%edx
 758:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 75b:	72 12                	jb     76f <free+0x40>
 75d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 760:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 763:	77 24                	ja     789 <free+0x5a>
 765:	8b 55 fc             	mov    -0x4(%ebp),%edx
 768:	8b 12                	mov    (%edx),%edx
 76a:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 76d:	72 1a                	jb     789 <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 772:	8b 12                	mov    (%edx),%edx
 774:	89 55 fc             	mov    %edx,-0x4(%ebp)
 777:	8b 55 f8             	mov    -0x8(%ebp),%edx
 77a:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 77d:	76 d4                	jbe    753 <free+0x24>
 77f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 782:	8b 12                	mov    (%edx),%edx
 784:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 787:	73 ca                	jae    753 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 789:	8b 55 f8             	mov    -0x8(%ebp),%edx
 78c:	8b 52 04             	mov    0x4(%edx),%edx
 78f:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 796:	8b 55 f8             	mov    -0x8(%ebp),%edx
 799:	01 d1                	add    %edx,%ecx
 79b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 79e:	8b 12                	mov    (%edx),%edx
 7a0:	39 d1                	cmp    %edx,%ecx
 7a2:	75 24                	jne    7c8 <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 7a4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7a7:	8b 4a 04             	mov    0x4(%edx),%ecx
 7aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7ad:	8b 12                	mov    (%edx),%edx
 7af:	8b 52 04             	mov    0x4(%edx),%edx
 7b2:	01 d1                	add    %edx,%ecx
 7b4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7b7:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7ba:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7bd:	8b 12                	mov    (%edx),%edx
 7bf:	8b 0a                	mov    (%edx),%ecx
 7c1:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7c4:	89 0a                	mov    %ecx,(%edx)
 7c6:	eb 0a                	jmp    7d2 <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 7c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7cb:	8b 0a                	mov    (%edx),%ecx
 7cd:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7d0:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 7d2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7d5:	8b 52 04             	mov    0x4(%edx),%edx
 7d8:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 7df:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7e2:	01 ca                	add    %ecx,%edx
 7e4:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 7e7:	75 20                	jne    809 <free+0xda>
    p->s.size += bp->s.size;
 7e9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7ec:	8b 4a 04             	mov    0x4(%edx),%ecx
 7ef:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7f2:	8b 52 04             	mov    0x4(%edx),%edx
 7f5:	01 d1                	add    %edx,%ecx
 7f7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7fa:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 7fd:	8b 55 f8             	mov    -0x8(%ebp),%edx
 800:	8b 0a                	mov    (%edx),%ecx
 802:	8b 55 fc             	mov    -0x4(%ebp),%edx
 805:	89 0a                	mov    %ecx,(%edx)
 807:	eb 08                	jmp    811 <free+0xe2>
  } else
    p->s.ptr = bp;
 809:	8b 55 fc             	mov    -0x4(%ebp),%edx
 80c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 80f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 811:	8b 55 fc             	mov    -0x4(%ebp),%edx
 814:	89 90 30 00 00 00    	mov    %edx,0x30(%eax)
}
 81a:	90                   	nop
 81b:	c9                   	leave  
 81c:	c3                   	ret    

0000081d <morecore>:

static Header*
morecore(uint nu)
{
 81d:	55                   	push   %ebp
 81e:	89 e5                	mov    %esp,%ebp
 820:	53                   	push   %ebx
 821:	83 ec 14             	sub    $0x14,%esp
 824:	e8 f6 f8 ff ff       	call   11f <__x86.get_pc_thunk.bx>
 829:	81 c3 57 04 00 00    	add    $0x457,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 82f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 836:	77 07                	ja     83f <morecore+0x22>
    nu = 4096;
 838:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 83f:	8b 45 08             	mov    0x8(%ebp),%eax
 842:	c1 e0 03             	shl    $0x3,%eax
 845:	83 ec 0c             	sub    $0xc,%esp
 848:	50                   	push   %eax
 849:	e8 26 fc ff ff       	call   474 <sbrk>
 84e:	83 c4 10             	add    $0x10,%esp
 851:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 854:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 858:	75 07                	jne    861 <morecore+0x44>
    return 0;
 85a:	b8 00 00 00 00       	mov    $0x0,%eax
 85f:	eb 27                	jmp    888 <morecore+0x6b>
  hp = (Header*)p;
 861:	8b 45 f4             	mov    -0xc(%ebp),%eax
 864:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 867:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86a:	8b 55 08             	mov    0x8(%ebp),%edx
 86d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 870:	8b 45 f0             	mov    -0x10(%ebp),%eax
 873:	83 c0 08             	add    $0x8,%eax
 876:	83 ec 0c             	sub    $0xc,%esp
 879:	50                   	push   %eax
 87a:	e8 b0 fe ff ff       	call   72f <free>
 87f:	83 c4 10             	add    $0x10,%esp
  return freep;
 882:	8b 83 30 00 00 00    	mov    0x30(%ebx),%eax
}
 888:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 88b:	c9                   	leave  
 88c:	c3                   	ret    

0000088d <malloc>:

void*
malloc(uint nbytes)
{
 88d:	55                   	push   %ebp
 88e:	89 e5                	mov    %esp,%ebp
 890:	53                   	push   %ebx
 891:	83 ec 14             	sub    $0x14,%esp
 894:	e8 86 f8 ff ff       	call   11f <__x86.get_pc_thunk.bx>
 899:	81 c3 e7 03 00 00    	add    $0x3e7,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 89f:	8b 45 08             	mov    0x8(%ebp),%eax
 8a2:	83 c0 07             	add    $0x7,%eax
 8a5:	c1 e8 03             	shr    $0x3,%eax
 8a8:	83 c0 01             	add    $0x1,%eax
 8ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8ae:	8b 83 30 00 00 00    	mov    0x30(%ebx),%eax
 8b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8bb:	75 28                	jne    8e5 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 8bd:	8d 83 28 00 00 00    	lea    0x28(%ebx),%eax
 8c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c9:	89 83 30 00 00 00    	mov    %eax,0x30(%ebx)
 8cf:	8b 83 30 00 00 00    	mov    0x30(%ebx),%eax
 8d5:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
    base.s.size = 0;
 8db:	c7 83 2c 00 00 00 00 	movl   $0x0,0x2c(%ebx)
 8e2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e8:	8b 00                	mov    (%eax),%eax
 8ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f0:	8b 40 04             	mov    0x4(%eax),%eax
 8f3:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 8f6:	77 4e                	ja     946 <malloc+0xb9>
      if(p->s.size == nunits)
 8f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fb:	8b 40 04             	mov    0x4(%eax),%eax
 8fe:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 901:	75 0c                	jne    90f <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 903:	8b 45 f4             	mov    -0xc(%ebp),%eax
 906:	8b 10                	mov    (%eax),%edx
 908:	8b 45 f0             	mov    -0x10(%ebp),%eax
 90b:	89 10                	mov    %edx,(%eax)
 90d:	eb 26                	jmp    935 <malloc+0xa8>
      else {
        p->s.size -= nunits;
 90f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 912:	8b 40 04             	mov    0x4(%eax),%eax
 915:	2b 45 ec             	sub    -0x14(%ebp),%eax
 918:	89 c2                	mov    %eax,%edx
 91a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 920:	8b 45 f4             	mov    -0xc(%ebp),%eax
 923:	8b 40 04             	mov    0x4(%eax),%eax
 926:	c1 e0 03             	shl    $0x3,%eax
 929:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 92c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 932:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 935:	8b 45 f0             	mov    -0x10(%ebp),%eax
 938:	89 83 30 00 00 00    	mov    %eax,0x30(%ebx)
      return (void*)(p + 1);
 93e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 941:	83 c0 08             	add    $0x8,%eax
 944:	eb 3c                	jmp    982 <malloc+0xf5>
    }
    if(p == freep)
 946:	8b 83 30 00 00 00    	mov    0x30(%ebx),%eax
 94c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 94f:	75 1e                	jne    96f <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 951:	83 ec 0c             	sub    $0xc,%esp
 954:	ff 75 ec             	push   -0x14(%ebp)
 957:	e8 c1 fe ff ff       	call   81d <morecore>
 95c:	83 c4 10             	add    $0x10,%esp
 95f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 962:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 966:	75 07                	jne    96f <malloc+0xe2>
        return 0;
 968:	b8 00 00 00 00       	mov    $0x0,%eax
 96d:	eb 13                	jmp    982 <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 972:	89 45 f0             	mov    %eax,-0x10(%ebp)
 975:	8b 45 f4             	mov    -0xc(%ebp),%eax
 978:	8b 00                	mov    (%eax),%eax
 97a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 97d:	e9 6b ff ff ff       	jmp    8ed <malloc+0x60>
  }
}
 982:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 985:	c9                   	leave  
 986:	c3                   	ret    
