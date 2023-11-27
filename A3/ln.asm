
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  13:	e8 6f 00 00 00       	call   87 <__x86.get_pc_thunk.bx>
  18:	81 c3 ac 0b 00 00    	add    $0xbac,%ebx
  1e:	89 ce                	mov    %ecx,%esi
  if(argc != 3){
  20:	83 3e 03             	cmpl   $0x3,(%esi)
  23:	74 19                	je     3e <main+0x3e>
    printf(2, "Usage: ln old new\n");
  25:	83 ec 08             	sub    $0x8,%esp
  28:	8d 83 2b fd ff ff    	lea    -0x2d5(%ebx),%eax
  2e:	50                   	push   %eax
  2f:	6a 02                	push   $0x2
  31:	e8 ba 04 00 00       	call   4f0 <printf>
  36:	83 c4 10             	add    $0x10,%esp
    exit();
  39:	e8 16 03 00 00       	call   354 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  3e:	8b 46 04             	mov    0x4(%esi),%eax
  41:	83 c0 08             	add    $0x8,%eax
  44:	8b 10                	mov    (%eax),%edx
  46:	8b 46 04             	mov    0x4(%esi),%eax
  49:	83 c0 04             	add    $0x4,%eax
  4c:	8b 00                	mov    (%eax),%eax
  4e:	83 ec 08             	sub    $0x8,%esp
  51:	52                   	push   %edx
  52:	50                   	push   %eax
  53:	e8 5c 03 00 00       	call   3b4 <link>
  58:	83 c4 10             	add    $0x10,%esp
  5b:	85 c0                	test   %eax,%eax
  5d:	79 23                	jns    82 <main+0x82>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  5f:	8b 46 04             	mov    0x4(%esi),%eax
  62:	83 c0 08             	add    $0x8,%eax
  65:	8b 10                	mov    (%eax),%edx
  67:	8b 46 04             	mov    0x4(%esi),%eax
  6a:	83 c0 04             	add    $0x4,%eax
  6d:	8b 00                	mov    (%eax),%eax
  6f:	52                   	push   %edx
  70:	50                   	push   %eax
  71:	8d 83 3e fd ff ff    	lea    -0x2c2(%ebx),%eax
  77:	50                   	push   %eax
  78:	6a 02                	push   $0x2
  7a:	e8 71 04 00 00       	call   4f0 <printf>
  7f:	83 c4 10             	add    $0x10,%esp
  exit();
  82:	e8 cd 02 00 00       	call   354 <exit>

00000087 <__x86.get_pc_thunk.bx>:
  87:	8b 1c 24             	mov    (%esp),%ebx
  8a:	c3                   	ret    

0000008b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  8b:	55                   	push   %ebp
  8c:	89 e5                	mov    %esp,%ebp
  8e:	57                   	push   %edi
  8f:	53                   	push   %ebx
  90:	e8 b3 02 00 00       	call   348 <__x86.get_pc_thunk.ax>
  95:	05 2f 0b 00 00       	add    $0xb2f,%eax
  asm volatile("cld; rep stosb" :
  9a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  9d:	8b 55 10             	mov    0x10(%ebp),%edx
  a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  a3:	89 cb                	mov    %ecx,%ebx
  a5:	89 df                	mov    %ebx,%edi
  a7:	89 d1                	mov    %edx,%ecx
  a9:	fc                   	cld    
  aa:	f3 aa                	rep stos %al,%es:(%edi)
  ac:	89 ca                	mov    %ecx,%edx
  ae:	89 fb                	mov    %edi,%ebx
  b0:	89 5d 08             	mov    %ebx,0x8(%ebp)
  b3:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b6:	90                   	nop
  b7:	5b                   	pop    %ebx
  b8:	5f                   	pop    %edi
  b9:	5d                   	pop    %ebp
  ba:	c3                   	ret    

000000bb <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  bb:	55                   	push   %ebp
  bc:	89 e5                	mov    %esp,%ebp
  be:	83 ec 10             	sub    $0x10,%esp
  c1:	e8 82 02 00 00       	call   348 <__x86.get_pc_thunk.ax>
  c6:	05 fe 0a 00 00       	add    $0xafe,%eax
  char *os;

  os = s;
  cb:	8b 45 08             	mov    0x8(%ebp),%eax
  ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  d1:	90                   	nop
  d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  d5:	8d 42 01             	lea    0x1(%edx),%eax
  d8:	89 45 0c             	mov    %eax,0xc(%ebp)
  db:	8b 45 08             	mov    0x8(%ebp),%eax
  de:	8d 48 01             	lea    0x1(%eax),%ecx
  e1:	89 4d 08             	mov    %ecx,0x8(%ebp)
  e4:	0f b6 12             	movzbl (%edx),%edx
  e7:	88 10                	mov    %dl,(%eax)
  e9:	0f b6 00             	movzbl (%eax),%eax
  ec:	84 c0                	test   %al,%al
  ee:	75 e2                	jne    d2 <strcpy+0x17>
    ;
  return os;
  f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  f3:	c9                   	leave  
  f4:	c3                   	ret    

000000f5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f5:	55                   	push   %ebp
  f6:	89 e5                	mov    %esp,%ebp
  f8:	e8 4b 02 00 00       	call   348 <__x86.get_pc_thunk.ax>
  fd:	05 c7 0a 00 00       	add    $0xac7,%eax
  while(*p && *p == *q)
 102:	eb 08                	jmp    10c <strcmp+0x17>
    p++, q++;
 104:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 108:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 10c:	8b 45 08             	mov    0x8(%ebp),%eax
 10f:	0f b6 00             	movzbl (%eax),%eax
 112:	84 c0                	test   %al,%al
 114:	74 10                	je     126 <strcmp+0x31>
 116:	8b 45 08             	mov    0x8(%ebp),%eax
 119:	0f b6 10             	movzbl (%eax),%edx
 11c:	8b 45 0c             	mov    0xc(%ebp),%eax
 11f:	0f b6 00             	movzbl (%eax),%eax
 122:	38 c2                	cmp    %al,%dl
 124:	74 de                	je     104 <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
 126:	8b 45 08             	mov    0x8(%ebp),%eax
 129:	0f b6 00             	movzbl (%eax),%eax
 12c:	0f b6 d0             	movzbl %al,%edx
 12f:	8b 45 0c             	mov    0xc(%ebp),%eax
 132:	0f b6 00             	movzbl (%eax),%eax
 135:	0f b6 c8             	movzbl %al,%ecx
 138:	89 d0                	mov    %edx,%eax
 13a:	29 c8                	sub    %ecx,%eax
}
 13c:	5d                   	pop    %ebp
 13d:	c3                   	ret    

0000013e <strlen>:

uint
strlen(const char *s)
{
 13e:	55                   	push   %ebp
 13f:	89 e5                	mov    %esp,%ebp
 141:	83 ec 10             	sub    $0x10,%esp
 144:	e8 ff 01 00 00       	call   348 <__x86.get_pc_thunk.ax>
 149:	05 7b 0a 00 00       	add    $0xa7b,%eax
  int n;

  for(n = 0; s[n]; n++)
 14e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 155:	eb 04                	jmp    15b <strlen+0x1d>
 157:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 15b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 15e:	8b 45 08             	mov    0x8(%ebp),%eax
 161:	01 d0                	add    %edx,%eax
 163:	0f b6 00             	movzbl (%eax),%eax
 166:	84 c0                	test   %al,%al
 168:	75 ed                	jne    157 <strlen+0x19>
    ;
  return n;
 16a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 16d:	c9                   	leave  
 16e:	c3                   	ret    

0000016f <memset>:

void*
memset(void *dst, int c, uint n)
{
 16f:	55                   	push   %ebp
 170:	89 e5                	mov    %esp,%ebp
 172:	e8 d1 01 00 00       	call   348 <__x86.get_pc_thunk.ax>
 177:	05 4d 0a 00 00       	add    $0xa4d,%eax
  stosb(dst, c, n);
 17c:	8b 45 10             	mov    0x10(%ebp),%eax
 17f:	50                   	push   %eax
 180:	ff 75 0c             	push   0xc(%ebp)
 183:	ff 75 08             	push   0x8(%ebp)
 186:	e8 00 ff ff ff       	call   8b <stosb>
 18b:	83 c4 0c             	add    $0xc,%esp
  return dst;
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 191:	c9                   	leave  
 192:	c3                   	ret    

00000193 <strchr>:

char*
strchr(const char *s, char c)
{
 193:	55                   	push   %ebp
 194:	89 e5                	mov    %esp,%ebp
 196:	83 ec 04             	sub    $0x4,%esp
 199:	e8 aa 01 00 00       	call   348 <__x86.get_pc_thunk.ax>
 19e:	05 26 0a 00 00       	add    $0xa26,%eax
 1a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a6:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1a9:	eb 14                	jmp    1bf <strchr+0x2c>
    if(*s == c)
 1ab:	8b 45 08             	mov    0x8(%ebp),%eax
 1ae:	0f b6 00             	movzbl (%eax),%eax
 1b1:	38 45 fc             	cmp    %al,-0x4(%ebp)
 1b4:	75 05                	jne    1bb <strchr+0x28>
      return (char*)s;
 1b6:	8b 45 08             	mov    0x8(%ebp),%eax
 1b9:	eb 13                	jmp    1ce <strchr+0x3b>
  for(; *s; s++)
 1bb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1bf:	8b 45 08             	mov    0x8(%ebp),%eax
 1c2:	0f b6 00             	movzbl (%eax),%eax
 1c5:	84 c0                	test   %al,%al
 1c7:	75 e2                	jne    1ab <strchr+0x18>
  return 0;
 1c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1ce:	c9                   	leave  
 1cf:	c3                   	ret    

000001d0 <gets>:

char*
gets(char *buf, int max)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	83 ec 14             	sub    $0x14,%esp
 1d7:	e8 ab fe ff ff       	call   87 <__x86.get_pc_thunk.bx>
 1dc:	81 c3 e8 09 00 00    	add    $0x9e8,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1e9:	eb 42                	jmp    22d <gets+0x5d>
    cc = read(0, &c, 1);
 1eb:	83 ec 04             	sub    $0x4,%esp
 1ee:	6a 01                	push   $0x1
 1f0:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1f3:	50                   	push   %eax
 1f4:	6a 00                	push   $0x0
 1f6:	e8 71 01 00 00       	call   36c <read>
 1fb:	83 c4 10             	add    $0x10,%esp
 1fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 201:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 205:	7e 33                	jle    23a <gets+0x6a>
      break;
    buf[i++] = c;
 207:	8b 45 f4             	mov    -0xc(%ebp),%eax
 20a:	8d 50 01             	lea    0x1(%eax),%edx
 20d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 210:	89 c2                	mov    %eax,%edx
 212:	8b 45 08             	mov    0x8(%ebp),%eax
 215:	01 c2                	add    %eax,%edx
 217:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 21b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 21d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 221:	3c 0a                	cmp    $0xa,%al
 223:	74 16                	je     23b <gets+0x6b>
 225:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 229:	3c 0d                	cmp    $0xd,%al
 22b:	74 0e                	je     23b <gets+0x6b>
  for(i=0; i+1 < max; ){
 22d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 230:	83 c0 01             	add    $0x1,%eax
 233:	39 45 0c             	cmp    %eax,0xc(%ebp)
 236:	7f b3                	jg     1eb <gets+0x1b>
 238:	eb 01                	jmp    23b <gets+0x6b>
      break;
 23a:	90                   	nop
      break;
  }
  buf[i] = '\0';
 23b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 23e:	8b 45 08             	mov    0x8(%ebp),%eax
 241:	01 d0                	add    %edx,%eax
 243:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 246:	8b 45 08             	mov    0x8(%ebp),%eax
}
 249:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 24c:	c9                   	leave  
 24d:	c3                   	ret    

0000024e <stat>:

int
stat(const char *n, struct stat *st)
{
 24e:	55                   	push   %ebp
 24f:	89 e5                	mov    %esp,%ebp
 251:	53                   	push   %ebx
 252:	83 ec 14             	sub    $0x14,%esp
 255:	e8 2d fe ff ff       	call   87 <__x86.get_pc_thunk.bx>
 25a:	81 c3 6a 09 00 00    	add    $0x96a,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 260:	83 ec 08             	sub    $0x8,%esp
 263:	6a 00                	push   $0x0
 265:	ff 75 08             	push   0x8(%ebp)
 268:	e8 27 01 00 00       	call   394 <open>
 26d:	83 c4 10             	add    $0x10,%esp
 270:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 273:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 277:	79 07                	jns    280 <stat+0x32>
    return -1;
 279:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 27e:	eb 25                	jmp    2a5 <stat+0x57>
  r = fstat(fd, st);
 280:	83 ec 08             	sub    $0x8,%esp
 283:	ff 75 0c             	push   0xc(%ebp)
 286:	ff 75 f4             	push   -0xc(%ebp)
 289:	e8 1e 01 00 00       	call   3ac <fstat>
 28e:	83 c4 10             	add    $0x10,%esp
 291:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 294:	83 ec 0c             	sub    $0xc,%esp
 297:	ff 75 f4             	push   -0xc(%ebp)
 29a:	e8 dd 00 00 00       	call   37c <close>
 29f:	83 c4 10             	add    $0x10,%esp
  return r;
 2a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2a8:	c9                   	leave  
 2a9:	c3                   	ret    

000002aa <atoi>:

int
atoi(const char *s)
{
 2aa:	55                   	push   %ebp
 2ab:	89 e5                	mov    %esp,%ebp
 2ad:	83 ec 10             	sub    $0x10,%esp
 2b0:	e8 93 00 00 00       	call   348 <__x86.get_pc_thunk.ax>
 2b5:	05 0f 09 00 00       	add    $0x90f,%eax
  int n;

  n = 0;
 2ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2c1:	eb 25                	jmp    2e8 <atoi+0x3e>
    n = n*10 + *s++ - '0';
 2c3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2c6:	89 d0                	mov    %edx,%eax
 2c8:	c1 e0 02             	shl    $0x2,%eax
 2cb:	01 d0                	add    %edx,%eax
 2cd:	01 c0                	add    %eax,%eax
 2cf:	89 c1                	mov    %eax,%ecx
 2d1:	8b 45 08             	mov    0x8(%ebp),%eax
 2d4:	8d 50 01             	lea    0x1(%eax),%edx
 2d7:	89 55 08             	mov    %edx,0x8(%ebp)
 2da:	0f b6 00             	movzbl (%eax),%eax
 2dd:	0f be c0             	movsbl %al,%eax
 2e0:	01 c8                	add    %ecx,%eax
 2e2:	83 e8 30             	sub    $0x30,%eax
 2e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2e8:	8b 45 08             	mov    0x8(%ebp),%eax
 2eb:	0f b6 00             	movzbl (%eax),%eax
 2ee:	3c 2f                	cmp    $0x2f,%al
 2f0:	7e 0a                	jle    2fc <atoi+0x52>
 2f2:	8b 45 08             	mov    0x8(%ebp),%eax
 2f5:	0f b6 00             	movzbl (%eax),%eax
 2f8:	3c 39                	cmp    $0x39,%al
 2fa:	7e c7                	jle    2c3 <atoi+0x19>
  return n;
 2fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2ff:	c9                   	leave  
 300:	c3                   	ret    

00000301 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 301:	55                   	push   %ebp
 302:	89 e5                	mov    %esp,%ebp
 304:	83 ec 10             	sub    $0x10,%esp
 307:	e8 3c 00 00 00       	call   348 <__x86.get_pc_thunk.ax>
 30c:	05 b8 08 00 00       	add    $0x8b8,%eax
  char *dst;
  const char *src;

  dst = vdst;
 311:	8b 45 08             	mov    0x8(%ebp),%eax
 314:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 317:	8b 45 0c             	mov    0xc(%ebp),%eax
 31a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 31d:	eb 17                	jmp    336 <memmove+0x35>
    *dst++ = *src++;
 31f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 322:	8d 42 01             	lea    0x1(%edx),%eax
 325:	89 45 f8             	mov    %eax,-0x8(%ebp)
 328:	8b 45 fc             	mov    -0x4(%ebp),%eax
 32b:	8d 48 01             	lea    0x1(%eax),%ecx
 32e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 331:	0f b6 12             	movzbl (%edx),%edx
 334:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 336:	8b 45 10             	mov    0x10(%ebp),%eax
 339:	8d 50 ff             	lea    -0x1(%eax),%edx
 33c:	89 55 10             	mov    %edx,0x10(%ebp)
 33f:	85 c0                	test   %eax,%eax
 341:	7f dc                	jg     31f <memmove+0x1e>
  return vdst;
 343:	8b 45 08             	mov    0x8(%ebp),%eax
}
 346:	c9                   	leave  
 347:	c3                   	ret    

00000348 <__x86.get_pc_thunk.ax>:
 348:	8b 04 24             	mov    (%esp),%eax
 34b:	c3                   	ret    

0000034c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34c:	b8 01 00 00 00       	mov    $0x1,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <exit>:
SYSCALL(exit)
 354:	b8 02 00 00 00       	mov    $0x2,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <wait>:
SYSCALL(wait)
 35c:	b8 03 00 00 00       	mov    $0x3,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <pipe>:
SYSCALL(pipe)
 364:	b8 04 00 00 00       	mov    $0x4,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <read>:
SYSCALL(read)
 36c:	b8 05 00 00 00       	mov    $0x5,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <write>:
SYSCALL(write)
 374:	b8 10 00 00 00       	mov    $0x10,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <close>:
SYSCALL(close)
 37c:	b8 15 00 00 00       	mov    $0x15,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <kill>:
SYSCALL(kill)
 384:	b8 06 00 00 00       	mov    $0x6,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <exec>:
SYSCALL(exec)
 38c:	b8 07 00 00 00       	mov    $0x7,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <open>:
SYSCALL(open)
 394:	b8 0f 00 00 00       	mov    $0xf,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <mknod>:
SYSCALL(mknod)
 39c:	b8 11 00 00 00       	mov    $0x11,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <unlink>:
SYSCALL(unlink)
 3a4:	b8 12 00 00 00       	mov    $0x12,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <fstat>:
SYSCALL(fstat)
 3ac:	b8 08 00 00 00       	mov    $0x8,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <link>:
SYSCALL(link)
 3b4:	b8 13 00 00 00       	mov    $0x13,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <mkdir>:
SYSCALL(mkdir)
 3bc:	b8 14 00 00 00       	mov    $0x14,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <chdir>:
SYSCALL(chdir)
 3c4:	b8 09 00 00 00       	mov    $0x9,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <dup>:
SYSCALL(dup)
 3cc:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <getpid>:
SYSCALL(getpid)
 3d4:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <sbrk>:
SYSCALL(sbrk)
 3dc:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <sleep>:
SYSCALL(sleep)
 3e4:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <uptime>:
SYSCALL(uptime)
 3ec:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <random>:
SYSCALL(random)
 3f4:	b8 16 00 00 00       	mov    $0x16,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3fc:	55                   	push   %ebp
 3fd:	89 e5                	mov    %esp,%ebp
 3ff:	53                   	push   %ebx
 400:	83 ec 14             	sub    $0x14,%esp
 403:	e8 40 ff ff ff       	call   348 <__x86.get_pc_thunk.ax>
 408:	05 bc 07 00 00       	add    $0x7bc,%eax
 40d:	8b 55 0c             	mov    0xc(%ebp),%edx
 410:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 413:	83 ec 04             	sub    $0x4,%esp
 416:	6a 01                	push   $0x1
 418:	8d 55 f4             	lea    -0xc(%ebp),%edx
 41b:	52                   	push   %edx
 41c:	ff 75 08             	push   0x8(%ebp)
 41f:	89 c3                	mov    %eax,%ebx
 421:	e8 4e ff ff ff       	call   374 <write>
 426:	83 c4 10             	add    $0x10,%esp
}
 429:	90                   	nop
 42a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 42d:	c9                   	leave  
 42e:	c3                   	ret    

0000042f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 42f:	55                   	push   %ebp
 430:	89 e5                	mov    %esp,%ebp
 432:	53                   	push   %ebx
 433:	83 ec 24             	sub    $0x24,%esp
 436:	e8 58 02 00 00       	call   693 <__x86.get_pc_thunk.cx>
 43b:	81 c1 89 07 00 00    	add    $0x789,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 441:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 448:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 44c:	74 17                	je     465 <printint+0x36>
 44e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 452:	79 11                	jns    465 <printint+0x36>
    neg = 1;
 454:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 45b:	8b 45 0c             	mov    0xc(%ebp),%eax
 45e:	f7 d8                	neg    %eax
 460:	89 45 ec             	mov    %eax,-0x14(%ebp)
 463:	eb 06                	jmp    46b <printint+0x3c>
  } else {
    x = xx;
 465:	8b 45 0c             	mov    0xc(%ebp),%eax
 468:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 46b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 472:	8b 5d 10             	mov    0x10(%ebp),%ebx
 475:	8b 45 ec             	mov    -0x14(%ebp),%eax
 478:	ba 00 00 00 00       	mov    $0x0,%edx
 47d:	f7 f3                	div    %ebx
 47f:	89 d3                	mov    %edx,%ebx
 481:	8b 45 f4             	mov    -0xc(%ebp),%eax
 484:	8d 50 01             	lea    0x1(%eax),%edx
 487:	89 55 f4             	mov    %edx,-0xc(%ebp)
 48a:	0f b6 94 19 0c 00 00 	movzbl 0xc(%ecx,%ebx,1),%edx
 491:	00 
 492:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 496:	8b 5d 10             	mov    0x10(%ebp),%ebx
 499:	8b 45 ec             	mov    -0x14(%ebp),%eax
 49c:	ba 00 00 00 00       	mov    $0x0,%edx
 4a1:	f7 f3                	div    %ebx
 4a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4a6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4aa:	75 c6                	jne    472 <printint+0x43>
  if(neg)
 4ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4b0:	74 2d                	je     4df <printint+0xb0>
    buf[i++] = '-';
 4b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4b5:	8d 50 01             	lea    0x1(%eax),%edx
 4b8:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4bb:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4c0:	eb 1d                	jmp    4df <printint+0xb0>
    putc(fd, buf[i]);
 4c2:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4c8:	01 d0                	add    %edx,%eax
 4ca:	0f b6 00             	movzbl (%eax),%eax
 4cd:	0f be c0             	movsbl %al,%eax
 4d0:	83 ec 08             	sub    $0x8,%esp
 4d3:	50                   	push   %eax
 4d4:	ff 75 08             	push   0x8(%ebp)
 4d7:	e8 20 ff ff ff       	call   3fc <putc>
 4dc:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 4df:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4e7:	79 d9                	jns    4c2 <printint+0x93>
}
 4e9:	90                   	nop
 4ea:	90                   	nop
 4eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4ee:	c9                   	leave  
 4ef:	c3                   	ret    

000004f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	53                   	push   %ebx
 4f4:	83 ec 24             	sub    $0x24,%esp
 4f7:	e8 8b fb ff ff       	call   87 <__x86.get_pc_thunk.bx>
 4fc:	81 c3 c8 06 00 00    	add    $0x6c8,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 502:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 509:	8d 45 0c             	lea    0xc(%ebp),%eax
 50c:	83 c0 04             	add    $0x4,%eax
 50f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 512:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 519:	e9 5b 01 00 00       	jmp    679 <printf+0x189>
    c = fmt[i] & 0xff;
 51e:	8b 55 0c             	mov    0xc(%ebp),%edx
 521:	8b 45 f0             	mov    -0x10(%ebp),%eax
 524:	01 d0                	add    %edx,%eax
 526:	0f b6 00             	movzbl (%eax),%eax
 529:	0f be c0             	movsbl %al,%eax
 52c:	25 ff 00 00 00       	and    $0xff,%eax
 531:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 534:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 538:	75 2c                	jne    566 <printf+0x76>
      if(c == '%'){
 53a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 53e:	75 0c                	jne    54c <printf+0x5c>
        state = '%';
 540:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 547:	e9 29 01 00 00       	jmp    675 <printf+0x185>
      } else {
        putc(fd, c);
 54c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 54f:	0f be c0             	movsbl %al,%eax
 552:	83 ec 08             	sub    $0x8,%esp
 555:	50                   	push   %eax
 556:	ff 75 08             	push   0x8(%ebp)
 559:	e8 9e fe ff ff       	call   3fc <putc>
 55e:	83 c4 10             	add    $0x10,%esp
 561:	e9 0f 01 00 00       	jmp    675 <printf+0x185>
      }
    } else if(state == '%'){
 566:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 56a:	0f 85 05 01 00 00    	jne    675 <printf+0x185>
      if(c == 'd'){
 570:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 574:	75 1e                	jne    594 <printf+0xa4>
        printint(fd, *ap, 10, 1);
 576:	8b 45 e8             	mov    -0x18(%ebp),%eax
 579:	8b 00                	mov    (%eax),%eax
 57b:	6a 01                	push   $0x1
 57d:	6a 0a                	push   $0xa
 57f:	50                   	push   %eax
 580:	ff 75 08             	push   0x8(%ebp)
 583:	e8 a7 fe ff ff       	call   42f <printint>
 588:	83 c4 10             	add    $0x10,%esp
        ap++;
 58b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 58f:	e9 da 00 00 00       	jmp    66e <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 594:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 598:	74 06                	je     5a0 <printf+0xb0>
 59a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 59e:	75 1e                	jne    5be <printf+0xce>
        printint(fd, *ap, 16, 0);
 5a0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a3:	8b 00                	mov    (%eax),%eax
 5a5:	6a 00                	push   $0x0
 5a7:	6a 10                	push   $0x10
 5a9:	50                   	push   %eax
 5aa:	ff 75 08             	push   0x8(%ebp)
 5ad:	e8 7d fe ff ff       	call   42f <printint>
 5b2:	83 c4 10             	add    $0x10,%esp
        ap++;
 5b5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b9:	e9 b0 00 00 00       	jmp    66e <printf+0x17e>
      } else if(c == 's'){
 5be:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5c2:	75 45                	jne    609 <printf+0x119>
        s = (char*)*ap;
 5c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c7:	8b 00                	mov    (%eax),%eax
 5c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5cc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5d4:	75 27                	jne    5fd <printf+0x10d>
          s = "(null)";
 5d6:	8d 83 52 fd ff ff    	lea    -0x2ae(%ebx),%eax
 5dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 5df:	eb 1c                	jmp    5fd <printf+0x10d>
          putc(fd, *s);
 5e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e4:	0f b6 00             	movzbl (%eax),%eax
 5e7:	0f be c0             	movsbl %al,%eax
 5ea:	83 ec 08             	sub    $0x8,%esp
 5ed:	50                   	push   %eax
 5ee:	ff 75 08             	push   0x8(%ebp)
 5f1:	e8 06 fe ff ff       	call   3fc <putc>
 5f6:	83 c4 10             	add    $0x10,%esp
          s++;
 5f9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 600:	0f b6 00             	movzbl (%eax),%eax
 603:	84 c0                	test   %al,%al
 605:	75 da                	jne    5e1 <printf+0xf1>
 607:	eb 65                	jmp    66e <printf+0x17e>
        }
      } else if(c == 'c'){
 609:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 60d:	75 1d                	jne    62c <printf+0x13c>
        putc(fd, *ap);
 60f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 612:	8b 00                	mov    (%eax),%eax
 614:	0f be c0             	movsbl %al,%eax
 617:	83 ec 08             	sub    $0x8,%esp
 61a:	50                   	push   %eax
 61b:	ff 75 08             	push   0x8(%ebp)
 61e:	e8 d9 fd ff ff       	call   3fc <putc>
 623:	83 c4 10             	add    $0x10,%esp
        ap++;
 626:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 62a:	eb 42                	jmp    66e <printf+0x17e>
      } else if(c == '%'){
 62c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 630:	75 17                	jne    649 <printf+0x159>
        putc(fd, c);
 632:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 635:	0f be c0             	movsbl %al,%eax
 638:	83 ec 08             	sub    $0x8,%esp
 63b:	50                   	push   %eax
 63c:	ff 75 08             	push   0x8(%ebp)
 63f:	e8 b8 fd ff ff       	call   3fc <putc>
 644:	83 c4 10             	add    $0x10,%esp
 647:	eb 25                	jmp    66e <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 649:	83 ec 08             	sub    $0x8,%esp
 64c:	6a 25                	push   $0x25
 64e:	ff 75 08             	push   0x8(%ebp)
 651:	e8 a6 fd ff ff       	call   3fc <putc>
 656:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 659:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 65c:	0f be c0             	movsbl %al,%eax
 65f:	83 ec 08             	sub    $0x8,%esp
 662:	50                   	push   %eax
 663:	ff 75 08             	push   0x8(%ebp)
 666:	e8 91 fd ff ff       	call   3fc <putc>
 66b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 66e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 675:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 679:	8b 55 0c             	mov    0xc(%ebp),%edx
 67c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 67f:	01 d0                	add    %edx,%eax
 681:	0f b6 00             	movzbl (%eax),%eax
 684:	84 c0                	test   %al,%al
 686:	0f 85 92 fe ff ff    	jne    51e <printf+0x2e>
    }
  }
}
 68c:	90                   	nop
 68d:	90                   	nop
 68e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 691:	c9                   	leave  
 692:	c3                   	ret    

00000693 <__x86.get_pc_thunk.cx>:
 693:	8b 0c 24             	mov    (%esp),%ecx
 696:	c3                   	ret    

00000697 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 697:	55                   	push   %ebp
 698:	89 e5                	mov    %esp,%ebp
 69a:	83 ec 10             	sub    $0x10,%esp
 69d:	e8 a6 fc ff ff       	call   348 <__x86.get_pc_thunk.ax>
 6a2:	05 22 05 00 00       	add    $0x522,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6a7:	8b 55 08             	mov    0x8(%ebp),%edx
 6aa:	83 ea 08             	sub    $0x8,%edx
 6ad:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b0:	8b 90 28 00 00 00    	mov    0x28(%eax),%edx
 6b6:	89 55 fc             	mov    %edx,-0x4(%ebp)
 6b9:	eb 24                	jmp    6df <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6be:	8b 12                	mov    (%edx),%edx
 6c0:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 6c3:	72 12                	jb     6d7 <free+0x40>
 6c5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6c8:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 6cb:	77 24                	ja     6f1 <free+0x5a>
 6cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6d0:	8b 12                	mov    (%edx),%edx
 6d2:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 6d5:	72 1a                	jb     6f1 <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6da:	8b 12                	mov    (%edx),%edx
 6dc:	89 55 fc             	mov    %edx,-0x4(%ebp)
 6df:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6e2:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 6e5:	76 d4                	jbe    6bb <free+0x24>
 6e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6ea:	8b 12                	mov    (%edx),%edx
 6ec:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 6ef:	73 ca                	jae    6bb <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f1:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6f4:	8b 52 04             	mov    0x4(%edx),%edx
 6f7:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 6fe:	8b 55 f8             	mov    -0x8(%ebp),%edx
 701:	01 d1                	add    %edx,%ecx
 703:	8b 55 fc             	mov    -0x4(%ebp),%edx
 706:	8b 12                	mov    (%edx),%edx
 708:	39 d1                	cmp    %edx,%ecx
 70a:	75 24                	jne    730 <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 70c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 70f:	8b 4a 04             	mov    0x4(%edx),%ecx
 712:	8b 55 fc             	mov    -0x4(%ebp),%edx
 715:	8b 12                	mov    (%edx),%edx
 717:	8b 52 04             	mov    0x4(%edx),%edx
 71a:	01 d1                	add    %edx,%ecx
 71c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 71f:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 722:	8b 55 fc             	mov    -0x4(%ebp),%edx
 725:	8b 12                	mov    (%edx),%edx
 727:	8b 0a                	mov    (%edx),%ecx
 729:	8b 55 f8             	mov    -0x8(%ebp),%edx
 72c:	89 0a                	mov    %ecx,(%edx)
 72e:	eb 0a                	jmp    73a <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 730:	8b 55 fc             	mov    -0x4(%ebp),%edx
 733:	8b 0a                	mov    (%edx),%ecx
 735:	8b 55 f8             	mov    -0x8(%ebp),%edx
 738:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 73a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 73d:	8b 52 04             	mov    0x4(%edx),%edx
 740:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 747:	8b 55 fc             	mov    -0x4(%ebp),%edx
 74a:	01 ca                	add    %ecx,%edx
 74c:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 74f:	75 20                	jne    771 <free+0xda>
    p->s.size += bp->s.size;
 751:	8b 55 fc             	mov    -0x4(%ebp),%edx
 754:	8b 4a 04             	mov    0x4(%edx),%ecx
 757:	8b 55 f8             	mov    -0x8(%ebp),%edx
 75a:	8b 52 04             	mov    0x4(%edx),%edx
 75d:	01 d1                	add    %edx,%ecx
 75f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 762:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 765:	8b 55 f8             	mov    -0x8(%ebp),%edx
 768:	8b 0a                	mov    (%edx),%ecx
 76a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 76d:	89 0a                	mov    %ecx,(%edx)
 76f:	eb 08                	jmp    779 <free+0xe2>
  } else
    p->s.ptr = bp;
 771:	8b 55 fc             	mov    -0x4(%ebp),%edx
 774:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 777:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 779:	8b 55 fc             	mov    -0x4(%ebp),%edx
 77c:	89 90 28 00 00 00    	mov    %edx,0x28(%eax)
}
 782:	90                   	nop
 783:	c9                   	leave  
 784:	c3                   	ret    

00000785 <morecore>:

static Header*
morecore(uint nu)
{
 785:	55                   	push   %ebp
 786:	89 e5                	mov    %esp,%ebp
 788:	53                   	push   %ebx
 789:	83 ec 14             	sub    $0x14,%esp
 78c:	e8 f6 f8 ff ff       	call   87 <__x86.get_pc_thunk.bx>
 791:	81 c3 33 04 00 00    	add    $0x433,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 797:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 79e:	77 07                	ja     7a7 <morecore+0x22>
    nu = 4096;
 7a0:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7a7:	8b 45 08             	mov    0x8(%ebp),%eax
 7aa:	c1 e0 03             	shl    $0x3,%eax
 7ad:	83 ec 0c             	sub    $0xc,%esp
 7b0:	50                   	push   %eax
 7b1:	e8 26 fc ff ff       	call   3dc <sbrk>
 7b6:	83 c4 10             	add    $0x10,%esp
 7b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7bc:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7c0:	75 07                	jne    7c9 <morecore+0x44>
    return 0;
 7c2:	b8 00 00 00 00       	mov    $0x0,%eax
 7c7:	eb 27                	jmp    7f0 <morecore+0x6b>
  hp = (Header*)p;
 7c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d2:	8b 55 08             	mov    0x8(%ebp),%edx
 7d5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7db:	83 c0 08             	add    $0x8,%eax
 7de:	83 ec 0c             	sub    $0xc,%esp
 7e1:	50                   	push   %eax
 7e2:	e8 b0 fe ff ff       	call   697 <free>
 7e7:	83 c4 10             	add    $0x10,%esp
  return freep;
 7ea:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
}
 7f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7f3:	c9                   	leave  
 7f4:	c3                   	ret    

000007f5 <malloc>:

void*
malloc(uint nbytes)
{
 7f5:	55                   	push   %ebp
 7f6:	89 e5                	mov    %esp,%ebp
 7f8:	53                   	push   %ebx
 7f9:	83 ec 14             	sub    $0x14,%esp
 7fc:	e8 86 f8 ff ff       	call   87 <__x86.get_pc_thunk.bx>
 801:	81 c3 c3 03 00 00    	add    $0x3c3,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 807:	8b 45 08             	mov    0x8(%ebp),%eax
 80a:	83 c0 07             	add    $0x7,%eax
 80d:	c1 e8 03             	shr    $0x3,%eax
 810:	83 c0 01             	add    $0x1,%eax
 813:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 816:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 81c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 81f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 823:	75 28                	jne    84d <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 825:	8d 83 20 00 00 00    	lea    0x20(%ebx),%eax
 82b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 82e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 831:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
 837:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 83d:	89 83 20 00 00 00    	mov    %eax,0x20(%ebx)
    base.s.size = 0;
 843:	c7 83 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
 84a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 84d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 850:	8b 00                	mov    (%eax),%eax
 852:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 855:	8b 45 f4             	mov    -0xc(%ebp),%eax
 858:	8b 40 04             	mov    0x4(%eax),%eax
 85b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 85e:	77 4e                	ja     8ae <malloc+0xb9>
      if(p->s.size == nunits)
 860:	8b 45 f4             	mov    -0xc(%ebp),%eax
 863:	8b 40 04             	mov    0x4(%eax),%eax
 866:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 869:	75 0c                	jne    877 <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 86b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86e:	8b 10                	mov    (%eax),%edx
 870:	8b 45 f0             	mov    -0x10(%ebp),%eax
 873:	89 10                	mov    %edx,(%eax)
 875:	eb 26                	jmp    89d <malloc+0xa8>
      else {
        p->s.size -= nunits;
 877:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87a:	8b 40 04             	mov    0x4(%eax),%eax
 87d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 880:	89 c2                	mov    %eax,%edx
 882:	8b 45 f4             	mov    -0xc(%ebp),%eax
 885:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 888:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88b:	8b 40 04             	mov    0x4(%eax),%eax
 88e:	c1 e0 03             	shl    $0x3,%eax
 891:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 894:	8b 45 f4             	mov    -0xc(%ebp),%eax
 897:	8b 55 ec             	mov    -0x14(%ebp),%edx
 89a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 89d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a0:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
      return (void*)(p + 1);
 8a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a9:	83 c0 08             	add    $0x8,%eax
 8ac:	eb 3c                	jmp    8ea <malloc+0xf5>
    }
    if(p == freep)
 8ae:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 8b4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8b7:	75 1e                	jne    8d7 <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 8b9:	83 ec 0c             	sub    $0xc,%esp
 8bc:	ff 75 ec             	push   -0x14(%ebp)
 8bf:	e8 c1 fe ff ff       	call   785 <morecore>
 8c4:	83 c4 10             	add    $0x10,%esp
 8c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8ce:	75 07                	jne    8d7 <malloc+0xe2>
        return 0;
 8d0:	b8 00 00 00 00       	mov    $0x0,%eax
 8d5:	eb 13                	jmp    8ea <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8da:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e0:	8b 00                	mov    (%eax),%eax
 8e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8e5:	e9 6b ff ff ff       	jmp    855 <malloc+0x60>
  }
}
 8ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8ed:	c9                   	leave  
 8ee:	c3                   	ret    
