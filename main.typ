#import "@preview/diatypst:0.8.0": *
#import "@preview/cetz:0.3.4"

#show: slides.with(
  title: "Rotational Formalisms",
  date: "3/30/26",
  authors: "Ethan Lipson",

  // Optional Styling (for more and explanation of options take a look at the typst universe)
  ratio: 16 / 9,
  layout: "medium",
  title-color: blue.darken(60%),
  toc: false,
)

= Complex Numbers

== Euler's Formula

The celebrated _Euler's formula_

$ exp(i t) = cos t + i sin t $

Why might we expect this to be true?

== Exp and Relative Velocity

The defining property of $exp(k t)$ is

$ underbrace(dif / (dif t) exp(k t), "velocity") = k dot underbrace(exp(k t), "position") $

The constant $k$ is the relative velocity: the ratio of velocity to position.

== Example: Real $k$

Let $f(t) = exp(2t)$. Then $f'(t) = 2 f(t)$: the velocity is always $2 times$ the current value.

#align(center, cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // Axis
  set-style(stroke: gray + 0.5pt)
  line((-0.5, 0), (10, 0), mark: (end: ">", fill: black))

  // Tick marks
  for x in range(1, 10) {
    line((x, -0.1), (x, 0.1))
  }

  // Point at t=0: exp(0) = 1
  set-style(stroke: none)
  circle((1, 0), radius: 0.12, fill: blue)
  content((1, 0.6), text(fill: blue)[$t = 0$])

  // Velocity arrow at t=0
  set-style(stroke: blue + 1.5pt)
  line((1, -0.4), (1.7, -0.4), mark: (end: ">", fill: blue))
  content((1.5, -0.9), text(size: 0.7em, fill: blue)[vel $= 2 e^0 = 2$])

  // Point at t=0.5: exp(1) \u2248 2.7
  set-style(stroke: none)
  circle((2.7, 0), radius: 0.12, fill: red)
  content((2.7, 0.6), text(fill: red)[$t = 1\/2$])

  // Velocity arrow at t=0.5
  set-style(stroke: red + 1.5pt)
  line((2.7, -0.4), (4.5, -0.4), mark: (end: ">", fill: red))
  content((3.6, -0.9), text(size: 0.7em, fill: red)[vel $= 2 e^1$])

  // Point at t=1: exp(2) \u2248 7.4
  set-style(stroke: none)
  circle((7.4, 0), radius: 0.12, fill: purple)
  content((7.4, 0.6), text(fill: purple)[$t = 1$])

  // Velocity arrow at t=1
  set-style(stroke: purple + 1.5pt)
  line((7.4, -0.4), (11, -0.4), mark: (end: ">", fill: purple))
  content((8.3, -0.9), text(size: 0.7em, fill: purple)[vel $= 2 e^2$])
}))

As position grows, velocity grows proportionally

== Now What if $k = i$?

Now consider $f(t) = exp(i t)$. The rule $f'(t) = i dot f(t)$ says:

#align(center, box(stroke: blue + 1pt, inset: 12pt, radius: 4pt)[
  The velocity is always $i times$ the current position.
])

What does multiplying by $i$ do geometrically? It rotates by $90degree$ counterclockwise!

#align(center, cetz.canvas(length: 1.2cm, {
  import cetz.draw: *

  let r = 1.5

  // Axes
  set-style(stroke: gray + 0.5pt)
  line((-2, 0), (2, 0), mark: (end: ">", fill: black))
  line((0, -2), (0, 2), mark: (end: ">", fill: black))


  let pts = (
    ($1$, 0deg, (r + 0.3, -0.2)),
    ($i$, 90deg, (0.2, r + 0.3)),
    ($-1$, 180deg, (-r - 0.4, -0.2)),
    ($-i$, 270deg, (0.2, -r - 0.3)),
  )

  // Four arcs from z to z*i along the unit circle
  let colors = (blue, red, purple, olive)
  for k in range(4) {
    let (_, start-angle, _) = pts.at(k)
    let (_, end-angle, _) = pts.at(calc.rem(k + 1, 4))
    let start-pt = (calc.cos(start-angle) * r, calc.sin(start-angle) * r)
    let end-pt = (calc.cos(end-angle) * r, calc.sin(end-angle) * r)
    let mid-angle = start-angle + 45deg
    let bend-pt = (calc.cos(mid-angle) * (r + 0.4), calc.sin(mid-angle) * (r + 0.4))
    set-style(stroke: colors.at(k) + 1.5pt)
    bezier(start-pt, end-pt, bend-pt, mark: (end: ">", fill: colors.at(k)))
  }

  // Labels and dots at each point
  for (label, angle, pos) in pts {
    set-style(stroke: none)
    circle((calc.cos(angle) * r, calc.sin(angle) * r), radius: 0.06, fill: black)
    content(pos, label)
  }
}))

== Circular Motion in $CC$

#align(center, cetz.canvas(length: 1.5cm, {
  import cetz.draw: *

  let r = 1.8

  // Axes
  set-style(stroke: gray + 0.5pt)
  line((-2.3, 0), (2.3, 0), mark: (end: ">", fill: black))
  line((0, -2.3), (0, 2.3), mark: (end: ">", fill: black))

  // Unit circle
  set-style(stroke: gray.darken(20%) + 1pt)
  circle((0, 0), radius: r)

  // t = 0: point at (1, 0)
  let p0 = (r, 0)
  set-style(stroke: none)
  circle(p0, radius: 0.07, fill: blue)

  // Velocity at t=0: pointing up (i * 1 = i)
  set-style(stroke: blue + 2pt)
  line(p0, (r, 0.7), mark: (end: ">", fill: blue))
  content((r + 0.5, 0.4), text(size: 0.8em, fill: blue)[vel $= i$])

  // t = \u03c0/4: point at (cos 45degree, sin 45degree)
  let a = calc.cos(45deg) * r
  let p1 = (a, a)
  set-style(stroke: none)
  circle(p1, radius: 0.07, fill: red)

  // Velocity at t=\u03c0/4: i * (cos45 + i sin45) = -sin45 + i cos45, i.e. perpendicular
  set-style(stroke: red + 2pt)
  line(p1, (a - 0.5, a + 0.5), mark: (end: ">", fill: red))

  // t = \u03c0/2: point at (0, 1)
  let p2 = (0, r)
  set-style(stroke: none)
  circle(p2, radius: 0.07, fill: purple)

  // Velocity at t=\u03c0/2: i * i = -1, pointing left
  set-style(stroke: purple + 2pt)
  line(p2, (-0.7, r), mark: (end: ">", fill: purple))
  content((-0.5, r + 0.3), text(size: 0.8em, fill: purple)[vel $= -1$])
}))

So the velocity is always perpendicular to the position, and this is exactly what produces circular motion!

== Periodicity of $exp(i theta)$

Since $exp(i t)$ traces the unit circle, after a full revolution ($t = 2 pi$) we return to the start:

$ exp(2 pi i) = 1 $

So $exp(i theta)$ is periodic with period $2 pi i$:

$ exp(i theta) = exp(i (theta + 2 pi n)) quad "for any" n in ZZ $

The map $theta |-> exp(i theta)$ is surjective onto the unit circle, but not injective: every point has infinitely many preimages.

= Rotation Matrices

== The Same Idea in 3D

In the complex plane, multiplying by $i$ rotated a vector by $90degree$.

In $RR^3$, the cross product does the same thing: given a fixed axis $bold(omega)$, the map $bold(v) |-> bold(omega) times bold(v)$ is always $perp$ to $bold(v)$.

So a vector spinning around $bold(omega)$ satisfies

$ dif / (dif t) bold(v)(t) = bold(omega) times bold(v)(t) $

== Solving the ODE

We solved $f'(t) = k f(t)$ for a scalar $k$ with $exp(k t)$. Can we do the same here?

We need the right-hand side in the form $A bold(v)(t)$. Since the cross product is linear in $bold(v)$, we can write #box[$bold(omega) times bold(v) = [bold(omega)]_times bold(v)$], where

$ [bold(omega)]_times = mat(0, -omega_3, omega_2; omega_3, 0, -omega_1; -omega_2, omega_1, 0) $

Now our ODE is $bold(v)'(t) = [bold(omega)]_times bold(v)(t)$.

== The Matrix Exponential

We want $exp(t A)$ to satisfy the same characteristic property:

$ dif / (dif t) exp(t A) = A exp(t A) $

The power series gives us exactly this:

$ exp(A) = I + A + A^2 / 2! + A^3 / 3! + dots.c $

So the solution is $bold(v)(t) = exp(t [bold(omega)]_times) bold(v)(0)$: the velocity is always $bold(omega) times "position"$, always perpendicular. This is circular motion around the axis $bold(omega)$!

== Exp of a Skew-Symmetric Matrix is a Rotation

#align(center, cetz.canvas(length: 1.4cm, {
  import cetz.draw: *

  // Axis arrow (\u03c9)
  set-style(stroke: gray + 1.5pt)
  line((0, -1.5), (0, 2.2), mark: (end: ">", fill: gray))
  content((0.4, 2.2), $bold(omega)$)

  // Circle in perspective (ellipse)
  set-style(stroke: gray.darken(20%) + 1pt)
  let rx = 1.5
  let ry = 0.5
  circle((0, 0), radius: (rx, ry))

  // Vector v
  set-style(stroke: blue + 2pt)
  line((0, 0), (1.5, 0), mark: (end: ">", fill: blue))
  content((1.5, -0.3), text(fill: blue)[$bold(v)$])

  // Rotated vector
  set-style(stroke: red + 2pt)
  line((0, 0), (-0.9, 0.45), mark: (end: ">", fill: red))
  content((-1.2, 0.6), text(fill: red)[$R bold(v)$])

  // Velocity arrow (perpendicular)
  set-style(stroke: purple + 1.5pt)
  line((1.5, 0), (1.15, 0.7), mark: (end: ">", fill: purple))
  content((1.9, 0.6), text(size: 0.8em, fill: purple)[$bold(omega) times bold(v)$])

  // Curved arrow showing rotation
  set-style(stroke: black + 1pt)
  bezier((1.3, 0.3), (-0.5, 0.55), (0.5, 1.0), mark: (end: ">", fill: black))
}))

$ exp(t [bold(omega)]_times) = R(bold(omega), t) $

== Rotation Matrices $<==>$ Angle-Axis

Every rotation vector $bold(omega) in RR^3$ gives a rotation matrix via $exp([bold(omega)]_times)$, and every rotation matrix arises this way.

But same periodicity as $exp(i theta)$: a full $2 pi$ rotation around the axis changes nothing.

$ exp([bold(omega)]_times) = exp([(bold(omega) + 2 pi hat(bold(omega))) ]_times) $

$exp$ is surjective onto $"SO"(3)$, but each rotation matrix has infinitely many preimages, differing by $2 pi$ multiples along the axis.

= Quaternions

== The Quaternions

The _quaternions_ $HH$ extend $CC$ by adding two more imaginary units $j$ and $k$:

$ q = a + b i + c j + d k, quad a, b, c, d in RR $

The multiplication rules are:
$
  i^2 = j^2 = k^2 = -1 \
  i j = k \
  j k = i \
  k i = j
$

Multiplication is _not commutative_: $j i = -k$, etc.

Remind you of anything?

== Conjugate, Norm, and Inverse

The _conjugate_ of $q = a + b i + c j + d k$ is $overline(q) = a - b i - c j - d k$.

The product $q overline(q)$ gives the _squared norm_:
$ q overline(q) = a^2 + b^2 + c^2 + d^2 = |q|^2 $

If $|q| = 1$ (a _unit quaternion_), then $q overline(q) = 1$, so $overline(q)$ is the inverse of $q$:
$ q^(-1) = overline(q) $

== Left-Multiplication by $i$

What does $q |-> i q$ do to the four basis elements?

$
  1 & arrow.r.bar i  & quad quad quad j & arrow.r.bar k \
  i & arrow.r.bar -1 & quad quad quad k & arrow.r.bar -j
$

#align(center, cetz.canvas(length: 1.2cm, {
  import cetz.draw: *

  // (1, i) plane
  let cx1 = -2.5
  let r = 1.2

  set-style(stroke: gray + 0.5pt)
  line((cx1 - 1.7, 0), (cx1 + 1.7, 0), mark: (end: ">", fill: black))
  line((cx1, -1.7), (cx1, 1.7), mark: (end: ">", fill: black))

  let pts1 = (
    ($1$, 0deg, (cx1 + r + 0.3, -0.3)),
    ($i$, 90deg, (cx1 + 0.3, r + 0.3)),
    ($-1$, 180deg, (cx1 - r - 0.4, -0.3)),
    ($-i$, 270deg, (cx1 + 0.3, -r - 0.3)),
  )

  for k in range(4) {
    let (_, start-angle, _) = pts1.at(k)
    let (_, end-angle, _) = pts1.at(calc.rem(k + 1, 4))
    let start-pt = (cx1 + calc.cos(start-angle) * r, calc.sin(start-angle) * r)
    let end-pt = (cx1 + calc.cos(end-angle) * r, calc.sin(end-angle) * r)
    let mid-angle = start-angle + 45deg
    let bend-pt = (cx1 + calc.cos(mid-angle) * (r + 0.4), calc.sin(mid-angle) * (r + 0.4))
    set-style(stroke: blue + 1.5pt)
    bezier(start-pt, end-pt, bend-pt, mark: (end: ">", fill: blue))
  }

  for (label, angle, pos) in pts1 {
    set-style(stroke: none)
    circle((cx1 + calc.cos(angle) * r, calc.sin(angle) * r), radius: 0.06, fill: black)
    content(pos, label)
  }

  content((cx1, -2.3), text(fill: blue)[$chevron.l 1, i chevron.r$ plane: $90degree$])

  // (j, k) plane
  let cx2 = 2.5

  set-style(stroke: gray + 0.5pt)
  line((cx2 - 1.7, 0), (cx2 + 1.7, 0), mark: (end: ">", fill: black))
  line((cx2, -1.7), (cx2, 1.7), mark: (end: ">", fill: black))

  let pts2 = (
    ($j$, 0deg, (cx2 + r + 0.3, -0.3)),
    ($k$, 90deg, (cx2 + 0.3, r + 0.3)),
    ($-j$, 180deg, (cx2 - r - 0.4, -0.3)),
    ($-k$, 270deg, (cx2 + 0.3, -r - 0.3)),
  )

  for k in range(4) {
    let (_, start-angle, _) = pts2.at(k)
    let (_, end-angle, _) = pts2.at(calc.rem(k + 1, 4))
    let start-pt = (cx2 + calc.cos(start-angle) * r, calc.sin(start-angle) * r)
    let end-pt = (cx2 + calc.cos(end-angle) * r, calc.sin(end-angle) * r)
    let mid-angle = start-angle + 45deg
    let bend-pt = (cx2 + calc.cos(mid-angle) * (r + 0.4), calc.sin(mid-angle) * (r + 0.4))
    set-style(stroke: red + 1.5pt)
    bezier(start-pt, end-pt, bend-pt, mark: (end: ">", fill: red))
  }

  for (label, angle, pos) in pts2 {
    set-style(stroke: none)
    circle((cx2 + calc.cos(angle) * r, calc.sin(angle) * r), radius: 0.06, fill: black)
    content(pos, label)
  }

  content((cx2, -2.3), text(fill: red)[$chevron.l j, k chevron.r$ plane: $90degree$])
}))

Left-multiplication by $i$ rotates both planes by $90degree$ counterclockwise.

== Right-Multiplication by $overline(i)$

Now consider $q |-> q overline(i)$:

$
  1 & arrow.r.bar -i          & quad quad quad j & arrow.r.bar k \
  i & arrow.r.bar #hide[$-$]1 & quad quad quad k & arrow.r.bar -j
$

#align(center, cetz.canvas(length: 1.2cm, {
  import cetz.draw: *

  let cx1 = -2.5
  let r = 1.2

  // (1, i) plane --- REVERSED
  set-style(stroke: gray + 0.5pt)
  line((cx1 - 1.7, 0), (cx1 + 1.7, 0), mark: (end: ">", fill: black))
  line((cx1, -1.7), (cx1, 1.7), mark: (end: ">", fill: black))

  let pts1 = (
    ($1$, 0deg, (cx1 + r + 0.3, -0.3)),
    ($i$, 90deg, (cx1 + 0.3, r + 0.3)),
    ($-1$, 180deg, (cx1 - r - 0.4, -0.3)),
    ($-i$, 270deg, (cx1 + 0.3, -r - 0.3)),
  )

  // CW cycle: 1 → -i → -1 → i → 1
  let cw-order = (0, 3, 2, 1)
  for idx in range(4) {
    let from = cw-order.at(idx)
    let to = cw-order.at(calc.rem(idx + 1, 4))
    let (_, start-angle, _) = pts1.at(from)
    let (_, end-angle, _) = pts1.at(to)
    let start-pt = (cx1 + calc.cos(start-angle) * r, calc.sin(start-angle) * r)
    let end-pt = (cx1 + calc.cos(end-angle) * r, calc.sin(end-angle) * r)
    let mid-angle = start-angle - 45deg
    let bend-pt = (cx1 + calc.cos(mid-angle) * (r + 0.4), calc.sin(mid-angle) * (r + 0.4))
    set-style(stroke: blue + 1.5pt)
    bezier(start-pt, end-pt, bend-pt, mark: (end: ">", fill: blue))
  }

  for (label, angle, pos) in pts1 {
    set-style(stroke: none)
    circle((cx1 + calc.cos(angle) * r, calc.sin(angle) * r), radius: 0.06, fill: black)
    content(pos, label)
  }

  content((cx1, -2.3), text(fill: blue)[$chevron.l 1, i chevron.r$ plane: $-90degree$])

  // (j, k) plane --- same direction as left-mult
  let cx2 = 2.5

  set-style(stroke: gray + 0.5pt)
  line((cx2 - 1.7, 0), (cx2 + 1.7, 0), mark: (end: ">", fill: black))
  line((cx2, -1.7), (cx2, 1.7), mark: (end: ">", fill: black))

  let pts2 = (
    ($j$, 0deg, (cx2 + r + 0.3, -0.3)),
    ($k$, 90deg, (cx2 + 0.3, r + 0.3)),
    ($-j$, 180deg, (cx2 - r - 0.4, -0.3)),
    ($-k$, 270deg, (cx2 + 0.3, -r - 0.3)),
  )

  for k in range(4) {
    let (_, start-angle, _) = pts2.at(k)
    let (_, end-angle, _) = pts2.at(calc.rem(k + 1, 4))
    let start-pt = (cx2 + calc.cos(start-angle) * r, calc.sin(start-angle) * r)
    let end-pt = (cx2 + calc.cos(end-angle) * r, calc.sin(end-angle) * r)
    let mid-angle = start-angle + 45deg
    let bend-pt = (cx2 + calc.cos(mid-angle) * (r + 0.4), calc.sin(mid-angle) * (r + 0.4))
    set-style(stroke: red + 1.5pt)
    bezier(start-pt, end-pt, bend-pt, mark: (end: ">", fill: red))
  }

  for (label, angle, pos) in pts2 {
    set-style(stroke: none)
    circle((cx2 + calc.cos(angle) * r, calc.sin(angle) * r), radius: 0.06, fill: black)
    content(pos, label)
  }

  content((cx2, -2.3), text(fill: red)[$chevron.l j, k chevron.r$ plane: $90degree$])
}))

The $chevron.l j, k chevron.r$ plane behaves the same as left-multiplication, but the $chevron.l 1, i chevron.r$ cycle is reversed!

== The Sandwich Product $i q overline(i)$

Compose left-multiplication by $i$ with right-multiplication by $overline(i)$:

#align(center, table(
  columns: 3,
  stroke: none,
  align: center,
  table.header[*Plane*][*Left by $i$*][*Right by $overline(i)$*],
  table.hline(),
  [$chevron.l 1, i chevron.r$], [$90degree$], [$-90degree$],
  [$chevron.l j, k chevron.r$], [$90degree$], [$#hide[$-$]90degree$],
))

- $chevron.l 1, i chevron.r$ plane: $90degree - 90degree = 0degree$ --- *fixed!*
- $chevron.l j, k chevron.r$ plane: $90degree + 90degree = 180degree$ --- *rotated by $180degree$*

So $q |-> i q overline(i)$ rotates the $chevron.l j, k chevron.r$ plane (perpendicular to $i$) by $180degree$ while leaving the $chevron.l 1, i chevron.r$ plane unchanged.

== Generalizing to Any Unit Imaginary Quaternion

Nothing was special about $i$. For any unit imaginary quaternion $bold(u)$ (with $bold(u)^2 = -1$), we can decompose $HH = RR^4$ into:

- The $chevron.l 1, bold(u) chevron.r$ plane
- The plane perpendicular to $chevron.l 1, bold(u) chevron.r$ in $HH$

Then $q |-> bold(u) q overline(bold(u))$ rotates the perpendicular plane by $180degree$ while fixing the $chevron.l 1, bold(u) chevron.r$ plane.

== From $bold(90degree)$ to Arbitrary Angles

Recall from Euler's formula: $exp(i t)$ is a $t$-radian rotation in the complex plane.

The same applies in $HH$: for a unit imaginary quaternion $bold(u)$,

$ exp(bold(u) t) = cos t + bold(u) sin t $

Left-multiplying by $exp(bold(u) t)$ rotates both planes by $t$ radians. Right-multiplying by $overline(exp(bold(u) t))$ reverses the $chevron.l 1, bold(u) chevron.r$ rotation to $-t$ but keeps the perpendicular plane at $t$.

== The Sandwich Product $exp(bold(u) t) thin q thin overline(exp(bold(u) t))$

Composing both:

#align(center, table(
  columns: 3,
  stroke: none,
  align: center,
  table.header[*Plane*][*Left by $exp(bold(u) t)$*][*Right by $overline(exp(bold(u) t))$*],
  table.hline(),
  [$chevron.l 1, bold(u) chevron.r^(#hide[$perp$])$], [$t$], [$-t$],
  [$chevron.l 1, bold(u) chevron.r^perp$], [$t$], [$#hide[$-$]t$],
))

- $chevron.l 1, bold(u) chevron.r^(#hide[$perp$])$ plane: $t - t = 0#hide[$t$]$ --- *fixed*
- $chevron.l 1, bold(u) chevron.r^perp$ plane: $t + t = 2t$ --- *rotated by $2t$*

For a pure imaginary quaternion $bold(v) in "Im"(HH) tilde.equiv RR^3$, this is a rotation by angle $2t$ around axis $bold(u)$.

== The Quaternion Rotation Formula

Setting $theta = 2t$ and writing $q = exp(bold(u) thin theta\/2) = cos(theta\/2) + bold(u) sin(theta\/2)$:

#align(center, box(stroke: blue + 1pt, inset: 12pt, radius: 4pt)[
  To rotate $bold(v) in RR^3$ by angle $theta$ around unit axis $bold(u)$:
  $ bold(v) |-> q thin bold(v) thin overline(q), quad q = cos theta/2 + bold(u) sin theta/2 $
])

The half-angle appears because each side of the sandwich contributes half the rotation.

== Composing Quaternion Rotations

Rotate by $q$, then by $p$:

$ bold(v) |-> p (q thin bold(v) thin overline(q)) overline(p) = (p q) thin bold(v) thin overline((p q)) $

Since $overline(q) thin overline(p) = overline(p q)$, the composition of two quaternion rotations is just quaternion multiplication.

== Sign Ambiguity

Replacing $q$ with $-q$ in the sandwich product:

$ (-q) thin bold(v) thin overline((-q)) = (-q) thin bold(v) thin (-overline(q)) = q thin bold(v) thin overline(q) $

So $q$ and $-q$ represent the same rotation. The map from unit quaternions to rotations is surjective onto $"SO"(3)$, but $2$-to-$1$: every rotation has exactly two quaternion representatives, $plus.minus q$.

There is no continuous way to pick one: any global sign convention must have a discontinuity somewhere in $"SO"(3)$.

= Practical Considerations

== Why Not Just Use Angle-Axis?

We've shown that rotation matrices, quaternions, and the matrix exponential all reduce to angle-axis $(bold(u), theta)$ under the hood.

But angle-axis is expensive to _use_. Applying $(bold(u), theta)$ to a vector $bold(v)$ requires Rodrigues' formula:

$ bold(v) |-> bold(v) cos theta + (bold(u) times bold(v)) sin theta + bold(u) (bold(u) dot bold(v))(1 - cos theta) $

The composition of $(bold(u)_1, theta_1)$ and $(bold(u)_2, theta_2)$ is given by:

$
  theta &= 2 arccos(cos theta_1/2 cos theta_2/2 - sin theta_1/2 sin theta_2/2 (bold(u)_1 dot bold(u)_2)) \
  bold(u) &= (sin theta_1/2 cos theta_2/2 thin bold(u)_1 + cos theta_1/2 sin theta_2/2 thin bold(u)_2 + sin theta_1/2 sin theta_2/2 (bold(u)_1 times bold(u)_2)) / (sin theta/2)
$

== Matrices vs. Quaternions

#align(center, table(
  columns: 3,
  stroke: none,
  align: center,
  table.header[][*Rotation Matrix*][*Unit Quaternion*],
  table.hline(),
  [*Storage*], [9 floats], [4 floats],
  [*Apply to vector*], [15 ops], [30 ops],
  [*Compose*], [45 ops], [28 ops],
))

Rule of thumb:
- More *application* (rotating many vectors by the same rotation) $arrow.r$ matrices
- More *composition* (chaining many rotations) $arrow.r$ quaternions
- Angle-axis is easiest to understand for humans

#heading(numbering: none)[Appendix: Euler Angles]

== What Are Euler Angles?

Decompose a rotation into three successive rotations about coordinate axes:

$ R = R_z (gamma) thin R_y (beta) thin R_x (alpha) $

The three angles $(alpha, beta, gamma)$ parameterize $"SO"(3)$.

== Problem 1: Conventions

There is no single "Euler angles" --- you must choose:

- *Axis ordering*: $x y z$, $z y x$, $z x z$, $x z x$, ... (12 possible orderings)
- *Intrinsic vs. extrinsic*: rotations about the body's own axes, or about the fixed world axes?

This gives 24 distinct conventions, all called "Euler angles."

== Problem 2: Physics

Decomposing a rotation into three axis-aligned rotations is _unphysical_: real rotations do not privilege one axis over another.

This makes implementations of physics using Euler angles more complicated.

== Problem 3: Gimbal Lock

Consider the $x y z$ convention with $beta = 90degree$. Then $R_y (90degree)$ maps the $z$-axis onto the $x$-axis, so the first and last rotations now act around the _same_ axis:

$ R_x (alpha) thin R_y (90degree) thin R_z (gamma) = R_y (90degree) thin R_x (alpha - gamma) $

Only the difference $alpha - gamma$ matters. We have lost a degree of freedom.

Near gimbal lock, the angles become numerically unstable.

== Problem 4: Performance

Direct formulas for applying Euler angles exist, but they require evaluating six trigonometric functions ($sin$ and $cos$ of each angle). Trig operations are slow!!!

In practice, if you need to apply the rotation more than once, you convert to a matrix first anyway.

== They will bring only suffering and despair

Occasionally useful as a human interface, e.g. game engine inspectors where a designer adjusts pitch/yaw/roll by hand.

They should *never* be used as a software-internal representation. The convention ambiguity invites bugs, gimbal lock causes numerical issues, and computation is slow.
