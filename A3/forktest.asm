
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, const char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 04             	sub    $0x4,%esp
   7:	e8 30 01 00 00       	call   13c <__x86.get_pc_thunk.bx>
   c:	81 c3 fc 06 00 00    	add    $0x6fc,%ebx
  write(fd, s, strlen(s));
  12:	83 ec 0c             	sub    $0xc,%esp
  15:	ff 75 0c             	push   0xc(%ebp)
  18:	e8 d6 01 00 00       	call   1f3 <strlen>
  1d:	83 c4 10             	add    $0x10,%esp
  20:	83 ec 04             	sub    $0x4,%esp
  23:	50                   	push   %eax
  24:	ff 75 0c             	push   0xc(%ebp)
  27:	ff 75 08             	push   0x8(%ebp)
  2a:	e8 fa 03 00 00       	call   429 <write>
  2f:	83 c4 10             	add    $0x10,%esp
}
  32:	90                   	nop
  33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  36:	c9                   	leave  
  37:	c3                   	ret    

00000038 <forktest>:

void
forktest(void)
{
  38:	55                   	push   %ebp
  39:	89 e5                	mov    %esp,%ebp
  3b:	53                   	push   %ebx
  3c:	83 ec 14             	sub    $0x14,%esp
  3f:	e8 f8 00 00 00       	call   13c <__x86.get_pc_thunk.bx>
  44:	81 c3 c4 06 00 00    	add    $0x6c4,%ebx
  int n, pid;

  printf(1, "fork test\n");
  4a:	83 ec 08             	sub    $0x8,%esp
  4d:	8d 83 ac fd ff ff    	lea    -0x254(%ebx),%eax
  53:	50                   	push   %eax
  54:	6a 01                	push   $0x1
  56:	e8 a5 ff ff ff       	call   0 <printf>
  5b:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  5e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  65:	eb 1d                	jmp    84 <forktest+0x4c>
    pid = fork();
  67:	e8 95 03 00 00       	call   401 <fork>
  6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
  6f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  73:	78 1a                	js     8f <forktest+0x57>
      break;
    if(pid == 0)
  75:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  79:	75 05                	jne    80 <forktest+0x48>
      exit();
  7b:	e8 89 03 00 00       	call   409 <exit>
  for(n=0; n<N; n++){
  80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  84:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
  8b:	7e da                	jle    67 <forktest+0x2f>
  8d:	eb 01                	jmp    90 <forktest+0x58>
      break;
  8f:	90                   	nop
  }

  if(n == N){
  90:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
  97:	75 44                	jne    dd <forktest+0xa5>
    printf(1, "fork claimed to work N times!\n", N);
  99:	83 ec 04             	sub    $0x4,%esp
  9c:	68 e8 03 00 00       	push   $0x3e8
  a1:	8d 83 b8 fd ff ff    	lea    -0x248(%ebx),%eax
  a7:	50                   	push   %eax
  a8:	6a 01                	push   $0x1
  aa:	e8 51 ff ff ff       	call   0 <printf>
  af:	83 c4 10             	add    $0x10,%esp
    exit();
  b2:	e8 52 03 00 00       	call   409 <exit>
  }

  for(; n > 0; n--){
    if(wait() < 0){
  b7:	e8 55 03 00 00       	call   411 <wait>
  bc:	85 c0                	test   %eax,%eax
  be:	79 19                	jns    d9 <forktest+0xa1>
      printf(1, "wait stopped early\n");
  c0:	83 ec 08             	sub    $0x8,%esp
  c3:	8d 83 d7 fd ff ff    	lea    -0x229(%ebx),%eax
  c9:	50                   	push   %eax
  ca:	6a 01                	push   $0x1
  cc:	e8 2f ff ff ff       	call   0 <printf>
  d1:	83 c4 10             	add    $0x10,%esp
      exit();
  d4:	e8 30 03 00 00       	call   409 <exit>
  for(; n > 0; n--){
  d9:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  e1:	7f d4                	jg     b7 <forktest+0x7f>
    }
  }

  if(wait() != -1){
  e3:	e8 29 03 00 00       	call   411 <wait>
  e8:	83 f8 ff             	cmp    $0xffffffff,%eax
  eb:	74 19                	je     106 <forktest+0xce>
    printf(1, "wait got too many\n");
  ed:	83 ec 08             	sub    $0x8,%esp
  f0:	8d 83 eb fd ff ff    	lea    -0x215(%ebx),%eax
  f6:	50                   	push   %eax
  f7:	6a 01                	push   $0x1
  f9:	e8 02 ff ff ff       	call   0 <printf>
  fe:	83 c4 10             	add    $0x10,%esp
    exit();
 101:	e8 03 03 00 00       	call   409 <exit>
  }

  printf(1, "fork test OK\n");
 106:	83 ec 08             	sub    $0x8,%esp
 109:	8d 83 fe fd ff ff    	lea    -0x202(%ebx),%eax
 10f:	50                   	push   %eax
 110:	6a 01                	push   $0x1
 112:	e8 e9 fe ff ff       	call   0 <printf>
 117:	83 c4 10             	add    $0x10,%esp
}
 11a:	90                   	nop
 11b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 11e:	c9                   	leave  
 11f:	c3                   	ret    

00000120 <main>:

int
main(void)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	83 e4 f0             	and    $0xfffffff0,%esp
 127:	e8 10 00 00 00       	call   13c <__x86.get_pc_thunk.bx>
 12c:	81 c3 dc 05 00 00    	add    $0x5dc,%ebx
  forktest();
 132:	e8 01 ff ff ff       	call   38 <forktest>
  exit();
 137:	e8 cd 02 00 00       	call   409 <exit>

0000013c <__x86.get_pc_thunk.bx>:
 13c:	8b 1c 24             	mov    (%esp),%ebx
 13f:	c3                   	ret    

00000140 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	53                   	push   %ebx
 145:	e8 b3 02 00 00       	call   3fd <__x86.get_pc_thunk.ax>
 14a:	05 be 05 00 00       	add    $0x5be,%eax
  asm volatile("cld; rep stosb" :
 14f:	8b 4d 08             	mov    0x8(%ebp),%ecx
 152:	8b 55 10             	mov    0x10(%ebp),%edx
 155:	8b 45 0c             	mov    0xc(%ebp),%eax
 158:	89 cb                	mov    %ecx,%ebx
 15a:	89 df                	mov    %ebx,%edi
 15c:	89 d1                	mov    %edx,%ecx
 15e:	fc                   	cld    
 15f:	f3 aa                	rep stos %al,%es:(%edi)
 161:	89 ca                	mov    %ecx,%edx
 163:	89 fb                	mov    %edi,%ebx
 165:	89 5d 08             	mov    %ebx,0x8(%ebp)
 168:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 16b:	90                   	nop
 16c:	5b                   	pop    %ebx
 16d:	5f                   	pop    %edi
 16e:	5d                   	pop    %ebp
 16f:	c3                   	ret    

00000170 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	83 ec 10             	sub    $0x10,%esp
 176:	e8 82 02 00 00       	call   3fd <__x86.get_pc_thunk.ax>
 17b:	05 8d 05 00 00       	add    $0x58d,%eax
  char *os;

  os = s;
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 186:	90                   	nop
 187:	8b 55 0c             	mov    0xc(%ebp),%edx
 18a:	8d 42 01             	lea    0x1(%edx),%eax
 18d:	89 45 0c             	mov    %eax,0xc(%ebp)
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	8d 48 01             	lea    0x1(%eax),%ecx
 196:	89 4d 08             	mov    %ecx,0x8(%ebp)
 199:	0f b6 12             	movzbl (%edx),%edx
 19c:	88 10                	mov    %dl,(%eax)
 19e:	0f b6 00             	movzbl (%eax),%eax
 1a1:	84 c0                	test   %al,%al
 1a3:	75 e2                	jne    187 <strcpy+0x17>
    ;
  return os;
 1a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1a8:	c9                   	leave  
 1a9:	c3                   	ret    

000001aa <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1aa:	55                   	push   %ebp
 1ab:	89 e5                	mov    %esp,%ebp
 1ad:	e8 4b 02 00 00       	call   3fd <__x86.get_pc_thunk.ax>
 1b2:	05 56 05 00 00       	add    $0x556,%eax
  while(*p && *p == *q)
 1b7:	eb 08                	jmp    1c1 <strcmp+0x17>
    p++, q++;
 1b9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1bd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 1c1:	8b 45 08             	mov    0x8(%ebp),%eax
 1c4:	0f b6 00             	movzbl (%eax),%eax
 1c7:	84 c0                	test   %al,%al
 1c9:	74 10                	je     1db <strcmp+0x31>
 1cb:	8b 45 08             	mov    0x8(%ebp),%eax
 1ce:	0f b6 10             	movzbl (%eax),%edx
 1d1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d4:	0f b6 00             	movzbl (%eax),%eax
 1d7:	38 c2                	cmp    %al,%dl
 1d9:	74 de                	je     1b9 <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
 1db:	8b 45 08             	mov    0x8(%ebp),%eax
 1de:	0f b6 00             	movzbl (%eax),%eax
 1e1:	0f b6 d0             	movzbl %al,%edx
 1e4:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e7:	0f b6 00             	movzbl (%eax),%eax
 1ea:	0f b6 c8             	movzbl %al,%ecx
 1ed:	89 d0                	mov    %edx,%eax
 1ef:	29 c8                	sub    %ecx,%eax
}
 1f1:	5d                   	pop    %ebp
 1f2:	c3                   	ret    

000001f3 <strlen>:

uint
strlen(const char *s)
{
 1f3:	55                   	push   %ebp
 1f4:	89 e5                	mov    %esp,%ebp
 1f6:	83 ec 10             	sub    $0x10,%esp
 1f9:	e8 ff 01 00 00       	call   3fd <__x86.get_pc_thunk.ax>
 1fe:	05 0a 05 00 00       	add    $0x50a,%eax
  int n;

  for(n = 0; s[n]; n++)
 203:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 20a:	eb 04                	jmp    210 <strlen+0x1d>
 20c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 210:	8b 55 fc             	mov    -0x4(%ebp),%edx
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	01 d0                	add    %edx,%eax
 218:	0f b6 00             	movzbl (%eax),%eax
 21b:	84 c0                	test   %al,%al
 21d:	75 ed                	jne    20c <strlen+0x19>
    ;
  return n;
 21f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 222:	c9                   	leave  
 223:	c3                   	ret    

00000224 <memset>:

void*
memset(void *dst, int c, uint n)
{
 224:	55                   	push   %ebp
 225:	89 e5                	mov    %esp,%ebp
 227:	e8 d1 01 00 00       	call   3fd <__x86.get_pc_thunk.ax>
 22c:	05 dc 04 00 00       	add    $0x4dc,%eax
  stosb(dst, c, n);
 231:	8b 45 10             	mov    0x10(%ebp),%eax
 234:	50                   	push   %eax
 235:	ff 75 0c             	push   0xc(%ebp)
 238:	ff 75 08             	push   0x8(%ebp)
 23b:	e8 00 ff ff ff       	call   140 <stosb>
 240:	83 c4 0c             	add    $0xc,%esp
  return dst;
 243:	8b 45 08             	mov    0x8(%ebp),%eax
}
 246:	c9                   	leave  
 247:	c3                   	ret    

00000248 <strchr>:

char*
strchr(const char *s, char c)
{
 248:	55                   	push   %ebp
 249:	89 e5                	mov    %esp,%ebp
 24b:	83 ec 04             	sub    $0x4,%esp
 24e:	e8 aa 01 00 00       	call   3fd <__x86.get_pc_thunk.ax>
 253:	05 b5 04 00 00       	add    $0x4b5,%eax
 258:	8b 45 0c             	mov    0xc(%ebp),%eax
 25b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 25e:	eb 14                	jmp    274 <strchr+0x2c>
    if(*s == c)
 260:	8b 45 08             	mov    0x8(%ebp),%eax
 263:	0f b6 00             	movzbl (%eax),%eax
 266:	38 45 fc             	cmp    %al,-0x4(%ebp)
 269:	75 05                	jne    270 <strchr+0x28>
      return (char*)s;
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	eb 13                	jmp    283 <strchr+0x3b>
  for(; *s; s++)
 270:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	0f b6 00             	movzbl (%eax),%eax
 27a:	84 c0                	test   %al,%al
 27c:	75 e2                	jne    260 <strchr+0x18>
  return 0;
 27e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 283:	c9                   	leave  
 284:	c3                   	ret    

00000285 <gets>:

char*
gets(char *buf, int max)
{
 285:	55                   	push   %ebp
 286:	89 e5                	mov    %esp,%ebp
 288:	53                   	push   %ebx
 289:	83 ec 14             	sub    $0x14,%esp
 28c:	e8 ab fe ff ff       	call   13c <__x86.get_pc_thunk.bx>
 291:	81 c3 77 04 00 00    	add    $0x477,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 297:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 29e:	eb 42                	jmp    2e2 <gets+0x5d>
    cc = read(0, &c, 1);
 2a0:	83 ec 04             	sub    $0x4,%esp
 2a3:	6a 01                	push   $0x1
 2a5:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2a8:	50                   	push   %eax
 2a9:	6a 00                	push   $0x0
 2ab:	e8 71 01 00 00       	call   421 <read>
 2b0:	83 c4 10             	add    $0x10,%esp
 2b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2b6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2ba:	7e 33                	jle    2ef <gets+0x6a>
      break;
    buf[i++] = c;
 2bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2bf:	8d 50 01             	lea    0x1(%eax),%edx
 2c2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2c5:	89 c2                	mov    %eax,%edx
 2c7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ca:	01 c2                	add    %eax,%edx
 2cc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2d0:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2d2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2d6:	3c 0a                	cmp    $0xa,%al
 2d8:	74 16                	je     2f0 <gets+0x6b>
 2da:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2de:	3c 0d                	cmp    $0xd,%al
 2e0:	74 0e                	je     2f0 <gets+0x6b>
  for(i=0; i+1 < max; ){
 2e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2e5:	83 c0 01             	add    $0x1,%eax
 2e8:	39 45 0c             	cmp    %eax,0xc(%ebp)
 2eb:	7f b3                	jg     2a0 <gets+0x1b>
 2ed:	eb 01                	jmp    2f0 <gets+0x6b>
      break;
 2ef:	90                   	nop
      break;
  }
  buf[i] = '\0';
 2f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	01 d0                	add    %edx,%eax
 2f8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2fb:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 301:	c9                   	leave  
 302:	c3                   	ret    

00000303 <stat>:

int
stat(const char *n, struct stat *st)
{
 303:	55                   	push   %ebp
 304:	89 e5                	mov    %esp,%ebp
 306:	53                   	push   %ebx
 307:	83 ec 14             	sub    $0x14,%esp
 30a:	e8 2d fe ff ff       	call   13c <__x86.get_pc_thunk.bx>
 30f:	81 c3 f9 03 00 00    	add    $0x3f9,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 315:	83 ec 08             	sub    $0x8,%esp
 318:	6a 00                	push   $0x0
 31a:	ff 75 08             	push   0x8(%ebp)
 31d:	e8 27 01 00 00       	call   449 <open>
 322:	83 c4 10             	add    $0x10,%esp
 325:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 328:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 32c:	79 07                	jns    335 <stat+0x32>
    return -1;
 32e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 333:	eb 25                	jmp    35a <stat+0x57>
  r = fstat(fd, st);
 335:	83 ec 08             	sub    $0x8,%esp
 338:	ff 75 0c             	push   0xc(%ebp)
 33b:	ff 75 f4             	push   -0xc(%ebp)
 33e:	e8 1e 01 00 00       	call   461 <fstat>
 343:	83 c4 10             	add    $0x10,%esp
 346:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 349:	83 ec 0c             	sub    $0xc,%esp
 34c:	ff 75 f4             	push   -0xc(%ebp)
 34f:	e8 dd 00 00 00       	call   431 <close>
 354:	83 c4 10             	add    $0x10,%esp
  return r;
 357:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 35a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 35d:	c9                   	leave  
 35e:	c3                   	ret    

0000035f <atoi>:

int
atoi(const char *s)
{
 35f:	55                   	push   %ebp
 360:	89 e5                	mov    %esp,%ebp
 362:	83 ec 10             	sub    $0x10,%esp
 365:	e8 93 00 00 00       	call   3fd <__x86.get_pc_thunk.ax>
 36a:	05 9e 03 00 00       	add    $0x39e,%eax
  int n;

  n = 0;
 36f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 376:	eb 25                	jmp    39d <atoi+0x3e>
    n = n*10 + *s++ - '0';
 378:	8b 55 fc             	mov    -0x4(%ebp),%edx
 37b:	89 d0                	mov    %edx,%eax
 37d:	c1 e0 02             	shl    $0x2,%eax
 380:	01 d0                	add    %edx,%eax
 382:	01 c0                	add    %eax,%eax
 384:	89 c1                	mov    %eax,%ecx
 386:	8b 45 08             	mov    0x8(%ebp),%eax
 389:	8d 50 01             	lea    0x1(%eax),%edx
 38c:	89 55 08             	mov    %edx,0x8(%ebp)
 38f:	0f b6 00             	movzbl (%eax),%eax
 392:	0f be c0             	movsbl %al,%eax
 395:	01 c8                	add    %ecx,%eax
 397:	83 e8 30             	sub    $0x30,%eax
 39a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 39d:	8b 45 08             	mov    0x8(%ebp),%eax
 3a0:	0f b6 00             	movzbl (%eax),%eax
 3a3:	3c 2f                	cmp    $0x2f,%al
 3a5:	7e 0a                	jle    3b1 <atoi+0x52>
 3a7:	8b 45 08             	mov    0x8(%ebp),%eax
 3aa:	0f b6 00             	movzbl (%eax),%eax
 3ad:	3c 39                	cmp    $0x39,%al
 3af:	7e c7                	jle    378 <atoi+0x19>
  return n;
 3b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3b4:	c9                   	leave  
 3b5:	c3                   	ret    

000003b6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b6:	55                   	push   %ebp
 3b7:	89 e5                	mov    %esp,%ebp
 3b9:	83 ec 10             	sub    $0x10,%esp
 3bc:	e8 3c 00 00 00       	call   3fd <__x86.get_pc_thunk.ax>
 3c1:	05 47 03 00 00       	add    $0x347,%eax
  char *dst;
  const char *src;

  dst = vdst;
 3c6:	8b 45 08             	mov    0x8(%ebp),%eax
 3c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3cc:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3d2:	eb 17                	jmp    3eb <memmove+0x35>
    *dst++ = *src++;
 3d4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3d7:	8d 42 01             	lea    0x1(%edx),%eax
 3da:	89 45 f8             	mov    %eax,-0x8(%ebp)
 3dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3e0:	8d 48 01             	lea    0x1(%eax),%ecx
 3e3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 3e6:	0f b6 12             	movzbl (%edx),%edx
 3e9:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 3eb:	8b 45 10             	mov    0x10(%ebp),%eax
 3ee:	8d 50 ff             	lea    -0x1(%eax),%edx
 3f1:	89 55 10             	mov    %edx,0x10(%ebp)
 3f4:	85 c0                	test   %eax,%eax
 3f6:	7f dc                	jg     3d4 <memmove+0x1e>
  return vdst;
 3f8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3fb:	c9                   	leave  
 3fc:	c3                   	ret    

000003fd <__x86.get_pc_thunk.ax>:
 3fd:	8b 04 24             	mov    (%esp),%eax
 400:	c3                   	ret    

00000401 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 401:	b8 01 00 00 00       	mov    $0x1,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <exit>:
SYSCALL(exit)
 409:	b8 02 00 00 00       	mov    $0x2,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <wait>:
SYSCALL(wait)
 411:	b8 03 00 00 00       	mov    $0x3,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <pipe>:
SYSCALL(pipe)
 419:	b8 04 00 00 00       	mov    $0x4,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <read>:
SYSCALL(read)
 421:	b8 05 00 00 00       	mov    $0x5,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <write>:
SYSCALL(write)
 429:	b8 10 00 00 00       	mov    $0x10,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <close>:
SYSCALL(close)
 431:	b8 15 00 00 00       	mov    $0x15,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <kill>:
SYSCALL(kill)
 439:	b8 06 00 00 00       	mov    $0x6,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <exec>:
SYSCALL(exec)
 441:	b8 07 00 00 00       	mov    $0x7,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <open>:
SYSCALL(open)
 449:	b8 0f 00 00 00       	mov    $0xf,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <mknod>:
SYSCALL(mknod)
 451:	b8 11 00 00 00       	mov    $0x11,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    

00000459 <unlink>:
SYSCALL(unlink)
 459:	b8 12 00 00 00       	mov    $0x12,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret    

00000461 <fstat>:
SYSCALL(fstat)
 461:	b8 08 00 00 00       	mov    $0x8,%eax
 466:	cd 40                	int    $0x40
 468:	c3                   	ret    

00000469 <link>:
SYSCALL(link)
 469:	b8 13 00 00 00       	mov    $0x13,%eax
 46e:	cd 40                	int    $0x40
 470:	c3                   	ret    

00000471 <mkdir>:
SYSCALL(mkdir)
 471:	b8 14 00 00 00       	mov    $0x14,%eax
 476:	cd 40                	int    $0x40
 478:	c3                   	ret    

00000479 <chdir>:
SYSCALL(chdir)
 479:	b8 09 00 00 00       	mov    $0x9,%eax
 47e:	cd 40                	int    $0x40
 480:	c3                   	ret    

00000481 <dup>:
SYSCALL(dup)
 481:	b8 0a 00 00 00       	mov    $0xa,%eax
 486:	cd 40                	int    $0x40
 488:	c3                   	ret    

00000489 <getpid>:
SYSCALL(getpid)
 489:	b8 0b 00 00 00       	mov    $0xb,%eax
 48e:	cd 40                	int    $0x40
 490:	c3                   	ret    

00000491 <sbrk>:
SYSCALL(sbrk)
 491:	b8 0c 00 00 00       	mov    $0xc,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret    

00000499 <sleep>:
SYSCALL(sleep)
 499:	b8 0d 00 00 00       	mov    $0xd,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret    

000004a1 <uptime>:
SYSCALL(uptime)
 4a1:	b8 0e 00 00 00       	mov    $0xe,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret    

000004a9 <random>:
SYSCALL(random)
 4a9:	b8 16 00 00 00       	mov    $0x16,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret    
