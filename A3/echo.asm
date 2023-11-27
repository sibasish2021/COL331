
_echo:     file format elf32-i386


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
  10:	83 ec 1c             	sub    $0x1c,%esp
  13:	e8 5d 00 00 00       	call   75 <__x86.get_pc_thunk.bx>
  18:	81 c3 7c 0b 00 00    	add    $0xb7c,%ebx
  1e:	89 ce                	mov    %ecx,%esi
  int i;

  for(i = 1; i < argc; i++)
  20:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  27:	eb 40                	jmp    69 <main+0x69>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  29:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  2c:	83 c0 01             	add    $0x1,%eax
  2f:	39 06                	cmp    %eax,(%esi)
  31:	7e 08                	jle    3b <main+0x3b>
  33:	8d 83 49 fd ff ff    	lea    -0x2b7(%ebx),%eax
  39:	eb 06                	jmp    41 <main+0x41>
  3b:	8d 83 4b fd ff ff    	lea    -0x2b5(%ebx),%eax
  41:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  44:	8d 0c 95 00 00 00 00 	lea    0x0(,%edx,4),%ecx
  4b:	8b 56 04             	mov    0x4(%esi),%edx
  4e:	01 ca                	add    %ecx,%edx
  50:	8b 12                	mov    (%edx),%edx
  52:	50                   	push   %eax
  53:	52                   	push   %edx
  54:	8d 83 4d fd ff ff    	lea    -0x2b3(%ebx),%eax
  5a:	50                   	push   %eax
  5b:	6a 01                	push   $0x1
  5d:	e8 7c 04 00 00       	call   4de <printf>
  62:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++)
  65:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
  69:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  6c:	3b 06                	cmp    (%esi),%eax
  6e:	7c b9                	jl     29 <main+0x29>
  exit();
  70:	e8 cd 02 00 00       	call   342 <exit>

00000075 <__x86.get_pc_thunk.bx>:
  75:	8b 1c 24             	mov    (%esp),%ebx
  78:	c3                   	ret    

00000079 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  79:	55                   	push   %ebp
  7a:	89 e5                	mov    %esp,%ebp
  7c:	57                   	push   %edi
  7d:	53                   	push   %ebx
  7e:	e8 b3 02 00 00       	call   336 <__x86.get_pc_thunk.ax>
  83:	05 11 0b 00 00       	add    $0xb11,%eax
  asm volatile("cld; rep stosb" :
  88:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8b:	8b 55 10             	mov    0x10(%ebp),%edx
  8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  91:	89 cb                	mov    %ecx,%ebx
  93:	89 df                	mov    %ebx,%edi
  95:	89 d1                	mov    %edx,%ecx
  97:	fc                   	cld    
  98:	f3 aa                	rep stos %al,%es:(%edi)
  9a:	89 ca                	mov    %ecx,%edx
  9c:	89 fb                	mov    %edi,%ebx
  9e:	89 5d 08             	mov    %ebx,0x8(%ebp)
  a1:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  a4:	90                   	nop
  a5:	5b                   	pop    %ebx
  a6:	5f                   	pop    %edi
  a7:	5d                   	pop    %ebp
  a8:	c3                   	ret    

000000a9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  a9:	55                   	push   %ebp
  aa:	89 e5                	mov    %esp,%ebp
  ac:	83 ec 10             	sub    $0x10,%esp
  af:	e8 82 02 00 00       	call   336 <__x86.get_pc_thunk.ax>
  b4:	05 e0 0a 00 00       	add    $0xae0,%eax
  char *os;

  os = s;
  b9:	8b 45 08             	mov    0x8(%ebp),%eax
  bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  bf:	90                   	nop
  c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  c3:	8d 42 01             	lea    0x1(%edx),%eax
  c6:	89 45 0c             	mov    %eax,0xc(%ebp)
  c9:	8b 45 08             	mov    0x8(%ebp),%eax
  cc:	8d 48 01             	lea    0x1(%eax),%ecx
  cf:	89 4d 08             	mov    %ecx,0x8(%ebp)
  d2:	0f b6 12             	movzbl (%edx),%edx
  d5:	88 10                	mov    %dl,(%eax)
  d7:	0f b6 00             	movzbl (%eax),%eax
  da:	84 c0                	test   %al,%al
  dc:	75 e2                	jne    c0 <strcpy+0x17>
    ;
  return os;
  de:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e1:	c9                   	leave  
  e2:	c3                   	ret    

000000e3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e3:	55                   	push   %ebp
  e4:	89 e5                	mov    %esp,%ebp
  e6:	e8 4b 02 00 00       	call   336 <__x86.get_pc_thunk.ax>
  eb:	05 a9 0a 00 00       	add    $0xaa9,%eax
  while(*p && *p == *q)
  f0:	eb 08                	jmp    fa <strcmp+0x17>
    p++, q++;
  f2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  f6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  fa:	8b 45 08             	mov    0x8(%ebp),%eax
  fd:	0f b6 00             	movzbl (%eax),%eax
 100:	84 c0                	test   %al,%al
 102:	74 10                	je     114 <strcmp+0x31>
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	0f b6 10             	movzbl (%eax),%edx
 10a:	8b 45 0c             	mov    0xc(%ebp),%eax
 10d:	0f b6 00             	movzbl (%eax),%eax
 110:	38 c2                	cmp    %al,%dl
 112:	74 de                	je     f2 <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	0f b6 00             	movzbl (%eax),%eax
 11a:	0f b6 d0             	movzbl %al,%edx
 11d:	8b 45 0c             	mov    0xc(%ebp),%eax
 120:	0f b6 00             	movzbl (%eax),%eax
 123:	0f b6 c8             	movzbl %al,%ecx
 126:	89 d0                	mov    %edx,%eax
 128:	29 c8                	sub    %ecx,%eax
}
 12a:	5d                   	pop    %ebp
 12b:	c3                   	ret    

0000012c <strlen>:

uint
strlen(const char *s)
{
 12c:	55                   	push   %ebp
 12d:	89 e5                	mov    %esp,%ebp
 12f:	83 ec 10             	sub    $0x10,%esp
 132:	e8 ff 01 00 00       	call   336 <__x86.get_pc_thunk.ax>
 137:	05 5d 0a 00 00       	add    $0xa5d,%eax
  int n;

  for(n = 0; s[n]; n++)
 13c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 143:	eb 04                	jmp    149 <strlen+0x1d>
 145:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 149:	8b 55 fc             	mov    -0x4(%ebp),%edx
 14c:	8b 45 08             	mov    0x8(%ebp),%eax
 14f:	01 d0                	add    %edx,%eax
 151:	0f b6 00             	movzbl (%eax),%eax
 154:	84 c0                	test   %al,%al
 156:	75 ed                	jne    145 <strlen+0x19>
    ;
  return n;
 158:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 15b:	c9                   	leave  
 15c:	c3                   	ret    

0000015d <memset>:

void*
memset(void *dst, int c, uint n)
{
 15d:	55                   	push   %ebp
 15e:	89 e5                	mov    %esp,%ebp
 160:	e8 d1 01 00 00       	call   336 <__x86.get_pc_thunk.ax>
 165:	05 2f 0a 00 00       	add    $0xa2f,%eax
  stosb(dst, c, n);
 16a:	8b 45 10             	mov    0x10(%ebp),%eax
 16d:	50                   	push   %eax
 16e:	ff 75 0c             	push   0xc(%ebp)
 171:	ff 75 08             	push   0x8(%ebp)
 174:	e8 00 ff ff ff       	call   79 <stosb>
 179:	83 c4 0c             	add    $0xc,%esp
  return dst;
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 17f:	c9                   	leave  
 180:	c3                   	ret    

00000181 <strchr>:

char*
strchr(const char *s, char c)
{
 181:	55                   	push   %ebp
 182:	89 e5                	mov    %esp,%ebp
 184:	83 ec 04             	sub    $0x4,%esp
 187:	e8 aa 01 00 00       	call   336 <__x86.get_pc_thunk.ax>
 18c:	05 08 0a 00 00       	add    $0xa08,%eax
 191:	8b 45 0c             	mov    0xc(%ebp),%eax
 194:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 197:	eb 14                	jmp    1ad <strchr+0x2c>
    if(*s == c)
 199:	8b 45 08             	mov    0x8(%ebp),%eax
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	38 45 fc             	cmp    %al,-0x4(%ebp)
 1a2:	75 05                	jne    1a9 <strchr+0x28>
      return (char*)s;
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	eb 13                	jmp    1bc <strchr+0x3b>
  for(; *s; s++)
 1a9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1ad:	8b 45 08             	mov    0x8(%ebp),%eax
 1b0:	0f b6 00             	movzbl (%eax),%eax
 1b3:	84 c0                	test   %al,%al
 1b5:	75 e2                	jne    199 <strchr+0x18>
  return 0;
 1b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1bc:	c9                   	leave  
 1bd:	c3                   	ret    

000001be <gets>:

char*
gets(char *buf, int max)
{
 1be:	55                   	push   %ebp
 1bf:	89 e5                	mov    %esp,%ebp
 1c1:	53                   	push   %ebx
 1c2:	83 ec 14             	sub    $0x14,%esp
 1c5:	e8 ab fe ff ff       	call   75 <__x86.get_pc_thunk.bx>
 1ca:	81 c3 ca 09 00 00    	add    $0x9ca,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1d7:	eb 42                	jmp    21b <gets+0x5d>
    cc = read(0, &c, 1);
 1d9:	83 ec 04             	sub    $0x4,%esp
 1dc:	6a 01                	push   $0x1
 1de:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1e1:	50                   	push   %eax
 1e2:	6a 00                	push   $0x0
 1e4:	e8 71 01 00 00       	call   35a <read>
 1e9:	83 c4 10             	add    $0x10,%esp
 1ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1f3:	7e 33                	jle    228 <gets+0x6a>
      break;
    buf[i++] = c;
 1f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f8:	8d 50 01             	lea    0x1(%eax),%edx
 1fb:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1fe:	89 c2                	mov    %eax,%edx
 200:	8b 45 08             	mov    0x8(%ebp),%eax
 203:	01 c2                	add    %eax,%edx
 205:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 209:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 20b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 20f:	3c 0a                	cmp    $0xa,%al
 211:	74 16                	je     229 <gets+0x6b>
 213:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 217:	3c 0d                	cmp    $0xd,%al
 219:	74 0e                	je     229 <gets+0x6b>
  for(i=0; i+1 < max; ){
 21b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 21e:	83 c0 01             	add    $0x1,%eax
 221:	39 45 0c             	cmp    %eax,0xc(%ebp)
 224:	7f b3                	jg     1d9 <gets+0x1b>
 226:	eb 01                	jmp    229 <gets+0x6b>
      break;
 228:	90                   	nop
      break;
  }
  buf[i] = '\0';
 229:	8b 55 f4             	mov    -0xc(%ebp),%edx
 22c:	8b 45 08             	mov    0x8(%ebp),%eax
 22f:	01 d0                	add    %edx,%eax
 231:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 234:	8b 45 08             	mov    0x8(%ebp),%eax
}
 237:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 23a:	c9                   	leave  
 23b:	c3                   	ret    

0000023c <stat>:

int
stat(const char *n, struct stat *st)
{
 23c:	55                   	push   %ebp
 23d:	89 e5                	mov    %esp,%ebp
 23f:	53                   	push   %ebx
 240:	83 ec 14             	sub    $0x14,%esp
 243:	e8 2d fe ff ff       	call   75 <__x86.get_pc_thunk.bx>
 248:	81 c3 4c 09 00 00    	add    $0x94c,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 24e:	83 ec 08             	sub    $0x8,%esp
 251:	6a 00                	push   $0x0
 253:	ff 75 08             	push   0x8(%ebp)
 256:	e8 27 01 00 00       	call   382 <open>
 25b:	83 c4 10             	add    $0x10,%esp
 25e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 261:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 265:	79 07                	jns    26e <stat+0x32>
    return -1;
 267:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 26c:	eb 25                	jmp    293 <stat+0x57>
  r = fstat(fd, st);
 26e:	83 ec 08             	sub    $0x8,%esp
 271:	ff 75 0c             	push   0xc(%ebp)
 274:	ff 75 f4             	push   -0xc(%ebp)
 277:	e8 1e 01 00 00       	call   39a <fstat>
 27c:	83 c4 10             	add    $0x10,%esp
 27f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 282:	83 ec 0c             	sub    $0xc,%esp
 285:	ff 75 f4             	push   -0xc(%ebp)
 288:	e8 dd 00 00 00       	call   36a <close>
 28d:	83 c4 10             	add    $0x10,%esp
  return r;
 290:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 293:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 296:	c9                   	leave  
 297:	c3                   	ret    

00000298 <atoi>:

int
atoi(const char *s)
{
 298:	55                   	push   %ebp
 299:	89 e5                	mov    %esp,%ebp
 29b:	83 ec 10             	sub    $0x10,%esp
 29e:	e8 93 00 00 00       	call   336 <__x86.get_pc_thunk.ax>
 2a3:	05 f1 08 00 00       	add    $0x8f1,%eax
  int n;

  n = 0;
 2a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2af:	eb 25                	jmp    2d6 <atoi+0x3e>
    n = n*10 + *s++ - '0';
 2b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2b4:	89 d0                	mov    %edx,%eax
 2b6:	c1 e0 02             	shl    $0x2,%eax
 2b9:	01 d0                	add    %edx,%eax
 2bb:	01 c0                	add    %eax,%eax
 2bd:	89 c1                	mov    %eax,%ecx
 2bf:	8b 45 08             	mov    0x8(%ebp),%eax
 2c2:	8d 50 01             	lea    0x1(%eax),%edx
 2c5:	89 55 08             	mov    %edx,0x8(%ebp)
 2c8:	0f b6 00             	movzbl (%eax),%eax
 2cb:	0f be c0             	movsbl %al,%eax
 2ce:	01 c8                	add    %ecx,%eax
 2d0:	83 e8 30             	sub    $0x30,%eax
 2d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2d6:	8b 45 08             	mov    0x8(%ebp),%eax
 2d9:	0f b6 00             	movzbl (%eax),%eax
 2dc:	3c 2f                	cmp    $0x2f,%al
 2de:	7e 0a                	jle    2ea <atoi+0x52>
 2e0:	8b 45 08             	mov    0x8(%ebp),%eax
 2e3:	0f b6 00             	movzbl (%eax),%eax
 2e6:	3c 39                	cmp    $0x39,%al
 2e8:	7e c7                	jle    2b1 <atoi+0x19>
  return n;
 2ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2ed:	c9                   	leave  
 2ee:	c3                   	ret    

000002ef <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2ef:	55                   	push   %ebp
 2f0:	89 e5                	mov    %esp,%ebp
 2f2:	83 ec 10             	sub    $0x10,%esp
 2f5:	e8 3c 00 00 00       	call   336 <__x86.get_pc_thunk.ax>
 2fa:	05 9a 08 00 00       	add    $0x89a,%eax
  char *dst;
  const char *src;

  dst = vdst;
 2ff:	8b 45 08             	mov    0x8(%ebp),%eax
 302:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 305:	8b 45 0c             	mov    0xc(%ebp),%eax
 308:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 30b:	eb 17                	jmp    324 <memmove+0x35>
    *dst++ = *src++;
 30d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 310:	8d 42 01             	lea    0x1(%edx),%eax
 313:	89 45 f8             	mov    %eax,-0x8(%ebp)
 316:	8b 45 fc             	mov    -0x4(%ebp),%eax
 319:	8d 48 01             	lea    0x1(%eax),%ecx
 31c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 31f:	0f b6 12             	movzbl (%edx),%edx
 322:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 324:	8b 45 10             	mov    0x10(%ebp),%eax
 327:	8d 50 ff             	lea    -0x1(%eax),%edx
 32a:	89 55 10             	mov    %edx,0x10(%ebp)
 32d:	85 c0                	test   %eax,%eax
 32f:	7f dc                	jg     30d <memmove+0x1e>
  return vdst;
 331:	8b 45 08             	mov    0x8(%ebp),%eax
}
 334:	c9                   	leave  
 335:	c3                   	ret    

00000336 <__x86.get_pc_thunk.ax>:
 336:	8b 04 24             	mov    (%esp),%eax
 339:	c3                   	ret    

0000033a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 33a:	b8 01 00 00 00       	mov    $0x1,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <exit>:
SYSCALL(exit)
 342:	b8 02 00 00 00       	mov    $0x2,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <wait>:
SYSCALL(wait)
 34a:	b8 03 00 00 00       	mov    $0x3,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <pipe>:
SYSCALL(pipe)
 352:	b8 04 00 00 00       	mov    $0x4,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <read>:
SYSCALL(read)
 35a:	b8 05 00 00 00       	mov    $0x5,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <write>:
SYSCALL(write)
 362:	b8 10 00 00 00       	mov    $0x10,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <close>:
SYSCALL(close)
 36a:	b8 15 00 00 00       	mov    $0x15,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <kill>:
SYSCALL(kill)
 372:	b8 06 00 00 00       	mov    $0x6,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <exec>:
SYSCALL(exec)
 37a:	b8 07 00 00 00       	mov    $0x7,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <open>:
SYSCALL(open)
 382:	b8 0f 00 00 00       	mov    $0xf,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <mknod>:
SYSCALL(mknod)
 38a:	b8 11 00 00 00       	mov    $0x11,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <unlink>:
SYSCALL(unlink)
 392:	b8 12 00 00 00       	mov    $0x12,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <fstat>:
SYSCALL(fstat)
 39a:	b8 08 00 00 00       	mov    $0x8,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <link>:
SYSCALL(link)
 3a2:	b8 13 00 00 00       	mov    $0x13,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <mkdir>:
SYSCALL(mkdir)
 3aa:	b8 14 00 00 00       	mov    $0x14,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <chdir>:
SYSCALL(chdir)
 3b2:	b8 09 00 00 00       	mov    $0x9,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <dup>:
SYSCALL(dup)
 3ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <getpid>:
SYSCALL(getpid)
 3c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <sbrk>:
SYSCALL(sbrk)
 3ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <sleep>:
SYSCALL(sleep)
 3d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <uptime>:
SYSCALL(uptime)
 3da:	b8 0e 00 00 00       	mov    $0xe,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <random>:
SYSCALL(random)
 3e2:	b8 16 00 00 00       	mov    $0x16,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3ea:	55                   	push   %ebp
 3eb:	89 e5                	mov    %esp,%ebp
 3ed:	53                   	push   %ebx
 3ee:	83 ec 14             	sub    $0x14,%esp
 3f1:	e8 40 ff ff ff       	call   336 <__x86.get_pc_thunk.ax>
 3f6:	05 9e 07 00 00       	add    $0x79e,%eax
 3fb:	8b 55 0c             	mov    0xc(%ebp),%edx
 3fe:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 401:	83 ec 04             	sub    $0x4,%esp
 404:	6a 01                	push   $0x1
 406:	8d 55 f4             	lea    -0xc(%ebp),%edx
 409:	52                   	push   %edx
 40a:	ff 75 08             	push   0x8(%ebp)
 40d:	89 c3                	mov    %eax,%ebx
 40f:	e8 4e ff ff ff       	call   362 <write>
 414:	83 c4 10             	add    $0x10,%esp
}
 417:	90                   	nop
 418:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 41b:	c9                   	leave  
 41c:	c3                   	ret    

0000041d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 41d:	55                   	push   %ebp
 41e:	89 e5                	mov    %esp,%ebp
 420:	53                   	push   %ebx
 421:	83 ec 24             	sub    $0x24,%esp
 424:	e8 58 02 00 00       	call   681 <__x86.get_pc_thunk.cx>
 429:	81 c1 6b 07 00 00    	add    $0x76b,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 42f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 436:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 43a:	74 17                	je     453 <printint+0x36>
 43c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 440:	79 11                	jns    453 <printint+0x36>
    neg = 1;
 442:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 449:	8b 45 0c             	mov    0xc(%ebp),%eax
 44c:	f7 d8                	neg    %eax
 44e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 451:	eb 06                	jmp    459 <printint+0x3c>
  } else {
    x = xx;
 453:	8b 45 0c             	mov    0xc(%ebp),%eax
 456:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 459:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 460:	8b 5d 10             	mov    0x10(%ebp),%ebx
 463:	8b 45 ec             	mov    -0x14(%ebp),%eax
 466:	ba 00 00 00 00       	mov    $0x0,%edx
 46b:	f7 f3                	div    %ebx
 46d:	89 d3                	mov    %edx,%ebx
 46f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 472:	8d 50 01             	lea    0x1(%eax),%edx
 475:	89 55 f4             	mov    %edx,-0xc(%ebp)
 478:	0f b6 94 19 0c 00 00 	movzbl 0xc(%ecx,%ebx,1),%edx
 47f:	00 
 480:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 484:	8b 5d 10             	mov    0x10(%ebp),%ebx
 487:	8b 45 ec             	mov    -0x14(%ebp),%eax
 48a:	ba 00 00 00 00       	mov    $0x0,%edx
 48f:	f7 f3                	div    %ebx
 491:	89 45 ec             	mov    %eax,-0x14(%ebp)
 494:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 498:	75 c6                	jne    460 <printint+0x43>
  if(neg)
 49a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 49e:	74 2d                	je     4cd <printint+0xb0>
    buf[i++] = '-';
 4a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a3:	8d 50 01             	lea    0x1(%eax),%edx
 4a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4a9:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4ae:	eb 1d                	jmp    4cd <printint+0xb0>
    putc(fd, buf[i]);
 4b0:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4b6:	01 d0                	add    %edx,%eax
 4b8:	0f b6 00             	movzbl (%eax),%eax
 4bb:	0f be c0             	movsbl %al,%eax
 4be:	83 ec 08             	sub    $0x8,%esp
 4c1:	50                   	push   %eax
 4c2:	ff 75 08             	push   0x8(%ebp)
 4c5:	e8 20 ff ff ff       	call   3ea <putc>
 4ca:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 4cd:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4d5:	79 d9                	jns    4b0 <printint+0x93>
}
 4d7:	90                   	nop
 4d8:	90                   	nop
 4d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4dc:	c9                   	leave  
 4dd:	c3                   	ret    

000004de <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4de:	55                   	push   %ebp
 4df:	89 e5                	mov    %esp,%ebp
 4e1:	53                   	push   %ebx
 4e2:	83 ec 24             	sub    $0x24,%esp
 4e5:	e8 8b fb ff ff       	call   75 <__x86.get_pc_thunk.bx>
 4ea:	81 c3 aa 06 00 00    	add    $0x6aa,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4f0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4f7:	8d 45 0c             	lea    0xc(%ebp),%eax
 4fa:	83 c0 04             	add    $0x4,%eax
 4fd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 500:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 507:	e9 5b 01 00 00       	jmp    667 <printf+0x189>
    c = fmt[i] & 0xff;
 50c:	8b 55 0c             	mov    0xc(%ebp),%edx
 50f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 512:	01 d0                	add    %edx,%eax
 514:	0f b6 00             	movzbl (%eax),%eax
 517:	0f be c0             	movsbl %al,%eax
 51a:	25 ff 00 00 00       	and    $0xff,%eax
 51f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 522:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 526:	75 2c                	jne    554 <printf+0x76>
      if(c == '%'){
 528:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 52c:	75 0c                	jne    53a <printf+0x5c>
        state = '%';
 52e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 535:	e9 29 01 00 00       	jmp    663 <printf+0x185>
      } else {
        putc(fd, c);
 53a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 53d:	0f be c0             	movsbl %al,%eax
 540:	83 ec 08             	sub    $0x8,%esp
 543:	50                   	push   %eax
 544:	ff 75 08             	push   0x8(%ebp)
 547:	e8 9e fe ff ff       	call   3ea <putc>
 54c:	83 c4 10             	add    $0x10,%esp
 54f:	e9 0f 01 00 00       	jmp    663 <printf+0x185>
      }
    } else if(state == '%'){
 554:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 558:	0f 85 05 01 00 00    	jne    663 <printf+0x185>
      if(c == 'd'){
 55e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 562:	75 1e                	jne    582 <printf+0xa4>
        printint(fd, *ap, 10, 1);
 564:	8b 45 e8             	mov    -0x18(%ebp),%eax
 567:	8b 00                	mov    (%eax),%eax
 569:	6a 01                	push   $0x1
 56b:	6a 0a                	push   $0xa
 56d:	50                   	push   %eax
 56e:	ff 75 08             	push   0x8(%ebp)
 571:	e8 a7 fe ff ff       	call   41d <printint>
 576:	83 c4 10             	add    $0x10,%esp
        ap++;
 579:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 57d:	e9 da 00 00 00       	jmp    65c <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 582:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 586:	74 06                	je     58e <printf+0xb0>
 588:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 58c:	75 1e                	jne    5ac <printf+0xce>
        printint(fd, *ap, 16, 0);
 58e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 591:	8b 00                	mov    (%eax),%eax
 593:	6a 00                	push   $0x0
 595:	6a 10                	push   $0x10
 597:	50                   	push   %eax
 598:	ff 75 08             	push   0x8(%ebp)
 59b:	e8 7d fe ff ff       	call   41d <printint>
 5a0:	83 c4 10             	add    $0x10,%esp
        ap++;
 5a3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5a7:	e9 b0 00 00 00       	jmp    65c <printf+0x17e>
      } else if(c == 's'){
 5ac:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5b0:	75 45                	jne    5f7 <printf+0x119>
        s = (char*)*ap;
 5b2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b5:	8b 00                	mov    (%eax),%eax
 5b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5ba:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5c2:	75 27                	jne    5eb <printf+0x10d>
          s = "(null)";
 5c4:	8d 83 52 fd ff ff    	lea    -0x2ae(%ebx),%eax
 5ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 5cd:	eb 1c                	jmp    5eb <printf+0x10d>
          putc(fd, *s);
 5cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d2:	0f b6 00             	movzbl (%eax),%eax
 5d5:	0f be c0             	movsbl %al,%eax
 5d8:	83 ec 08             	sub    $0x8,%esp
 5db:	50                   	push   %eax
 5dc:	ff 75 08             	push   0x8(%ebp)
 5df:	e8 06 fe ff ff       	call   3ea <putc>
 5e4:	83 c4 10             	add    $0x10,%esp
          s++;
 5e7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ee:	0f b6 00             	movzbl (%eax),%eax
 5f1:	84 c0                	test   %al,%al
 5f3:	75 da                	jne    5cf <printf+0xf1>
 5f5:	eb 65                	jmp    65c <printf+0x17e>
        }
      } else if(c == 'c'){
 5f7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5fb:	75 1d                	jne    61a <printf+0x13c>
        putc(fd, *ap);
 5fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 600:	8b 00                	mov    (%eax),%eax
 602:	0f be c0             	movsbl %al,%eax
 605:	83 ec 08             	sub    $0x8,%esp
 608:	50                   	push   %eax
 609:	ff 75 08             	push   0x8(%ebp)
 60c:	e8 d9 fd ff ff       	call   3ea <putc>
 611:	83 c4 10             	add    $0x10,%esp
        ap++;
 614:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 618:	eb 42                	jmp    65c <printf+0x17e>
      } else if(c == '%'){
 61a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 61e:	75 17                	jne    637 <printf+0x159>
        putc(fd, c);
 620:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 623:	0f be c0             	movsbl %al,%eax
 626:	83 ec 08             	sub    $0x8,%esp
 629:	50                   	push   %eax
 62a:	ff 75 08             	push   0x8(%ebp)
 62d:	e8 b8 fd ff ff       	call   3ea <putc>
 632:	83 c4 10             	add    $0x10,%esp
 635:	eb 25                	jmp    65c <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 637:	83 ec 08             	sub    $0x8,%esp
 63a:	6a 25                	push   $0x25
 63c:	ff 75 08             	push   0x8(%ebp)
 63f:	e8 a6 fd ff ff       	call   3ea <putc>
 644:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 647:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64a:	0f be c0             	movsbl %al,%eax
 64d:	83 ec 08             	sub    $0x8,%esp
 650:	50                   	push   %eax
 651:	ff 75 08             	push   0x8(%ebp)
 654:	e8 91 fd ff ff       	call   3ea <putc>
 659:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 65c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 663:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 667:	8b 55 0c             	mov    0xc(%ebp),%edx
 66a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 66d:	01 d0                	add    %edx,%eax
 66f:	0f b6 00             	movzbl (%eax),%eax
 672:	84 c0                	test   %al,%al
 674:	0f 85 92 fe ff ff    	jne    50c <printf+0x2e>
    }
  }
}
 67a:	90                   	nop
 67b:	90                   	nop
 67c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 67f:	c9                   	leave  
 680:	c3                   	ret    

00000681 <__x86.get_pc_thunk.cx>:
 681:	8b 0c 24             	mov    (%esp),%ecx
 684:	c3                   	ret    

00000685 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 685:	55                   	push   %ebp
 686:	89 e5                	mov    %esp,%ebp
 688:	83 ec 10             	sub    $0x10,%esp
 68b:	e8 a6 fc ff ff       	call   336 <__x86.get_pc_thunk.ax>
 690:	05 04 05 00 00       	add    $0x504,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 695:	8b 55 08             	mov    0x8(%ebp),%edx
 698:	83 ea 08             	sub    $0x8,%edx
 69b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69e:	8b 90 28 00 00 00    	mov    0x28(%eax),%edx
 6a4:	89 55 fc             	mov    %edx,-0x4(%ebp)
 6a7:	eb 24                	jmp    6cd <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6ac:	8b 12                	mov    (%edx),%edx
 6ae:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 6b1:	72 12                	jb     6c5 <free+0x40>
 6b3:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6b6:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 6b9:	77 24                	ja     6df <free+0x5a>
 6bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6be:	8b 12                	mov    (%edx),%edx
 6c0:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 6c3:	72 1a                	jb     6df <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6c8:	8b 12                	mov    (%edx),%edx
 6ca:	89 55 fc             	mov    %edx,-0x4(%ebp)
 6cd:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6d0:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 6d3:	76 d4                	jbe    6a9 <free+0x24>
 6d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6d8:	8b 12                	mov    (%edx),%edx
 6da:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 6dd:	73 ca                	jae    6a9 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6df:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6e2:	8b 52 04             	mov    0x4(%edx),%edx
 6e5:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 6ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6ef:	01 d1                	add    %edx,%ecx
 6f1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6f4:	8b 12                	mov    (%edx),%edx
 6f6:	39 d1                	cmp    %edx,%ecx
 6f8:	75 24                	jne    71e <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 6fa:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6fd:	8b 4a 04             	mov    0x4(%edx),%ecx
 700:	8b 55 fc             	mov    -0x4(%ebp),%edx
 703:	8b 12                	mov    (%edx),%edx
 705:	8b 52 04             	mov    0x4(%edx),%edx
 708:	01 d1                	add    %edx,%ecx
 70a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 70d:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 710:	8b 55 fc             	mov    -0x4(%ebp),%edx
 713:	8b 12                	mov    (%edx),%edx
 715:	8b 0a                	mov    (%edx),%ecx
 717:	8b 55 f8             	mov    -0x8(%ebp),%edx
 71a:	89 0a                	mov    %ecx,(%edx)
 71c:	eb 0a                	jmp    728 <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 71e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 721:	8b 0a                	mov    (%edx),%ecx
 723:	8b 55 f8             	mov    -0x8(%ebp),%edx
 726:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 728:	8b 55 fc             	mov    -0x4(%ebp),%edx
 72b:	8b 52 04             	mov    0x4(%edx),%edx
 72e:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 735:	8b 55 fc             	mov    -0x4(%ebp),%edx
 738:	01 ca                	add    %ecx,%edx
 73a:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 73d:	75 20                	jne    75f <free+0xda>
    p->s.size += bp->s.size;
 73f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 742:	8b 4a 04             	mov    0x4(%edx),%ecx
 745:	8b 55 f8             	mov    -0x8(%ebp),%edx
 748:	8b 52 04             	mov    0x4(%edx),%edx
 74b:	01 d1                	add    %edx,%ecx
 74d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 750:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 753:	8b 55 f8             	mov    -0x8(%ebp),%edx
 756:	8b 0a                	mov    (%edx),%ecx
 758:	8b 55 fc             	mov    -0x4(%ebp),%edx
 75b:	89 0a                	mov    %ecx,(%edx)
 75d:	eb 08                	jmp    767 <free+0xe2>
  } else
    p->s.ptr = bp;
 75f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 762:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 765:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 767:	8b 55 fc             	mov    -0x4(%ebp),%edx
 76a:	89 90 28 00 00 00    	mov    %edx,0x28(%eax)
}
 770:	90                   	nop
 771:	c9                   	leave  
 772:	c3                   	ret    

00000773 <morecore>:

static Header*
morecore(uint nu)
{
 773:	55                   	push   %ebp
 774:	89 e5                	mov    %esp,%ebp
 776:	53                   	push   %ebx
 777:	83 ec 14             	sub    $0x14,%esp
 77a:	e8 f6 f8 ff ff       	call   75 <__x86.get_pc_thunk.bx>
 77f:	81 c3 15 04 00 00    	add    $0x415,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 785:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 78c:	77 07                	ja     795 <morecore+0x22>
    nu = 4096;
 78e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 795:	8b 45 08             	mov    0x8(%ebp),%eax
 798:	c1 e0 03             	shl    $0x3,%eax
 79b:	83 ec 0c             	sub    $0xc,%esp
 79e:	50                   	push   %eax
 79f:	e8 26 fc ff ff       	call   3ca <sbrk>
 7a4:	83 c4 10             	add    $0x10,%esp
 7a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7aa:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7ae:	75 07                	jne    7b7 <morecore+0x44>
    return 0;
 7b0:	b8 00 00 00 00       	mov    $0x0,%eax
 7b5:	eb 27                	jmp    7de <morecore+0x6b>
  hp = (Header*)p;
 7b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c0:	8b 55 08             	mov    0x8(%ebp),%edx
 7c3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c9:	83 c0 08             	add    $0x8,%eax
 7cc:	83 ec 0c             	sub    $0xc,%esp
 7cf:	50                   	push   %eax
 7d0:	e8 b0 fe ff ff       	call   685 <free>
 7d5:	83 c4 10             	add    $0x10,%esp
  return freep;
 7d8:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
}
 7de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7e1:	c9                   	leave  
 7e2:	c3                   	ret    

000007e3 <malloc>:

void*
malloc(uint nbytes)
{
 7e3:	55                   	push   %ebp
 7e4:	89 e5                	mov    %esp,%ebp
 7e6:	53                   	push   %ebx
 7e7:	83 ec 14             	sub    $0x14,%esp
 7ea:	e8 86 f8 ff ff       	call   75 <__x86.get_pc_thunk.bx>
 7ef:	81 c3 a5 03 00 00    	add    $0x3a5,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f5:	8b 45 08             	mov    0x8(%ebp),%eax
 7f8:	83 c0 07             	add    $0x7,%eax
 7fb:	c1 e8 03             	shr    $0x3,%eax
 7fe:	83 c0 01             	add    $0x1,%eax
 801:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 804:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 80a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 80d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 811:	75 28                	jne    83b <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 813:	8d 83 20 00 00 00    	lea    0x20(%ebx),%eax
 819:	89 45 f0             	mov    %eax,-0x10(%ebp)
 81c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81f:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
 825:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 82b:	89 83 20 00 00 00    	mov    %eax,0x20(%ebx)
    base.s.size = 0;
 831:	c7 83 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
 838:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 83b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83e:	8b 00                	mov    (%eax),%eax
 840:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 843:	8b 45 f4             	mov    -0xc(%ebp),%eax
 846:	8b 40 04             	mov    0x4(%eax),%eax
 849:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 84c:	77 4e                	ja     89c <malloc+0xb9>
      if(p->s.size == nunits)
 84e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 851:	8b 40 04             	mov    0x4(%eax),%eax
 854:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 857:	75 0c                	jne    865 <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 859:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85c:	8b 10                	mov    (%eax),%edx
 85e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 861:	89 10                	mov    %edx,(%eax)
 863:	eb 26                	jmp    88b <malloc+0xa8>
      else {
        p->s.size -= nunits;
 865:	8b 45 f4             	mov    -0xc(%ebp),%eax
 868:	8b 40 04             	mov    0x4(%eax),%eax
 86b:	2b 45 ec             	sub    -0x14(%ebp),%eax
 86e:	89 c2                	mov    %eax,%edx
 870:	8b 45 f4             	mov    -0xc(%ebp),%eax
 873:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 876:	8b 45 f4             	mov    -0xc(%ebp),%eax
 879:	8b 40 04             	mov    0x4(%eax),%eax
 87c:	c1 e0 03             	shl    $0x3,%eax
 87f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 882:	8b 45 f4             	mov    -0xc(%ebp),%eax
 885:	8b 55 ec             	mov    -0x14(%ebp),%edx
 888:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 88b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88e:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
      return (void*)(p + 1);
 894:	8b 45 f4             	mov    -0xc(%ebp),%eax
 897:	83 c0 08             	add    $0x8,%eax
 89a:	eb 3c                	jmp    8d8 <malloc+0xf5>
    }
    if(p == freep)
 89c:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 8a2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8a5:	75 1e                	jne    8c5 <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 8a7:	83 ec 0c             	sub    $0xc,%esp
 8aa:	ff 75 ec             	push   -0x14(%ebp)
 8ad:	e8 c1 fe ff ff       	call   773 <morecore>
 8b2:	83 c4 10             	add    $0x10,%esp
 8b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8bc:	75 07                	jne    8c5 <malloc+0xe2>
        return 0;
 8be:	b8 00 00 00 00       	mov    $0x0,%eax
 8c3:	eb 13                	jmp    8d8 <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ce:	8b 00                	mov    (%eax),%eax
 8d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8d3:	e9 6b ff ff ff       	jmp    843 <malloc+0x60>
  }
}
 8d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8db:	c9                   	leave  
 8dc:	c3                   	ret    
