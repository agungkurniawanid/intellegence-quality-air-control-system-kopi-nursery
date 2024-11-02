<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    @vite('resources/css/app.css')

    <title>Gumukmas Multifarm - Kemitraan Domba dan Pakan Ternak Berkualitas</title>
    <meta property="og:title" content="Gumukmas Multifarm - Kemitraan Domba dan Pakan Ternak Berkualitas">
    <meta property="og:description"
        content="Bergabunglah dengan Gumukmas Multifarm untuk kemitraan domba, pakan ternak berkualitas, dan layanan terbaik di Jember, Jawa Timur.">
    <meta name="description"
        content="Gumukmas Multifarm menyediakan kemitraan domba, domba pejantan & indukan unggul, pengadaan bahan baku pakan ternak, dan produksi pakan ternak ruminansia di Jember, Jawa Timur. Hubungi kami untuk kemitraan sukses.">
    <meta name="keywords"
        content="Gumukmas Multifarm, kemitraan domba, domba pejantan, indukan unggul, pakan ternak, ruminansia, Jember, Jawa Timur, peternakan domba, kemitraan ternak, pakan ternak berkualitas, pengadaan pakan ternak, produksi pakan ternak, domba unggul, domba berkualitas, pakan ternak ruminansia, kemitraan sukses, peternak lokal, dukungan peternak, bimbingan kemitraan, ternak produktif, domba sehat, bahan baku pakan, pakan ruminansia, domba Jember, ternak Jember, domba Jawa Timur, ternak Jawa Timur, peternak Jawa Timur, supplier pakan ternak, distributor pakan ternak, penyedia pakan ternak, pakan ternak alami, pakan ternak sehat, pakan ternak efisien, produksi pakan berkualitas, ternak sehat, ternak unggul, ternak berkualitas, peternak unggul, peternakan modern, peternakan berkelanjutan, bisnis peternakan, investasi peternakan, usaha peternakan, pakan ternak murah, pakan ternak terbaik, nutrisi ternak, kebutuhan ternak, pakan ternak alami, kemitraan domba sukses, manajemen peternakan, agribisnis, agrikultur, peternakan Indonesia, ternak Indonesia, pasar ternak, peluang peternakan, ternak ruminansia, pakan ternak komplit, komposisi pakan ternak, formulasi pakan ternak, inovasi pakan ternak, teknologi peternakan, perkembangan peternakan, kemitraan peternakan, pengembangan peternakan, jasa peternakan, layanan peternakan, komunitas peternakan, industri peternakan, jaringan peternakan, kesehatan ternak, produktivitas ternak, perawatan ternak, pengelolaan ternak, sumber daya ternak, kualitas pakan ternak, standar pakan ternak, suplai pakan ternak, solusi pakan ternak, kebutuhan pakan ternak, stok pakan ternak, bahan pakan ternak, distribusi pakan ternak, pakan ternak premium, pakan ternak grosir, peternakan modern, tren peternakan, strategi peternakan, efisiensi peternakan, peternak sukses, peluang usaha peternakan, perkembangan agribisnis, pasar agrikultur, agrikultur Jawa Timur, peluang bisnis Jember, potensi peternakan, ternak Indonesia, dukungan peternak lokal, mitra peternak, usaha ternak, pengembangan ternak, bisnis ternak, pakan ternak lokal, peternakan lokal, ternak skala kecil, ternak skala besar, peternak mandiri, mitra peternak, pengusaha ternak">
    <meta name="author" content="Gumukmas Multifarm">
</head>

<body class="bg-lwhite">
    <!-- Start Hero Section -->
    <section id="hero" class="flex flex-col min-h-screen text-white bg-center bg-cover bg-blend-overlay "
        style="background-image: url('{{ asset('images/landingpage/herobackground.png') }}')">
        <div class="container">
            @livewire('components.header')
        </div>
        <div class="container">
            <div class="mx-auto p-4 md:py-8">
                <div class="flex-1 flex items-center">
                    <div class="text-center mx-auto">
                        <h1 class="text-h3 font-bold text-white md:text-h2 lg:text-h1">Selamat Datang di</h1>
                        <h1 class="text-h3 font-bold text-white md:text-h2 lg:text-h1">Gumukmas Multifarm (GMF)</h1>
                        <p class="text-title2 text-text mb-7">Kemitraan Domba dan Produksi Pakan Ternak Terbaik di
                            Jember,
                            Jawa
                            Timur, Indonesia</p>
                        <a href="#"
                            class="py-3 px-9 bg-orange text-title2 text-lwhite rounded-xl hover:bg-orange/80">Mulai
                            Bermitra</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Hero Section -->

    <!-- Start About Section -->
    <section id="about" class="pt-24 pb-16">
        <div class="container mx-auto">
            <div class="flex flex-col md:flex-row items-center sm:pt-4 md:px-0">
                <div class="order-2 md:order-1 w-full md:w-2/5 flex justify-center md:justify-start md:mb-0">
                    <img src="{{ asset('images/landingpage/aboutimage.png') }}" alt="About Image"
                        class="max-w-full h-auto object-cover">
                </div>
                <div class="order-1 mb-16 md:order-2 w-full md:w-3/5 md:pl-4">
                    <h2 class="text-h3 text-dgreen font-bold mb-4 xl:text-h2">Tentang Kami</h2>
                    <p class="text-body text-tblack leading-relaxed mb-12 xl:text-title2">
                        Gumukmas Multifarm (GMF) adalah perusahaan yang berkomitmen untuk meningkatkan kualitas dan
                        produktivitas peternakan di Indonesia. Kami fokus pada kemitraan domba serta penyediaan pakan
                        ternak
                        ruminansia berkualitas tinggi. Berlokasi di Jember, Jawa Timur, kami siap mendukung peternak
                        lokal
                        dengan layanan terbaik dan terpercaya.
                    </p>
                    <a href="#"
                        class="py-3 px-9 mb-8 bg-orange text-title2 text-lwhite rounded-xl hover:bg-orange/80">Mulai
                        Bermitra</a>
                </div>
            </div>
        </div>
    </section>
    <!-- End About Section -->

    {{-- Start Service section --}}
    <section id="service" class="py-4 md:py-16 relative">
        <div class="container mx-auto relative z-10">
            <div class="flex flex-col md:flex-row items-center sm:px-4">
                <div class="w-full md:w-1/2 order-1 mt-4">
                    <h2 class="text-h3 text-dgreen font-bold mr-4 mb-4 xl:text-h2">Layanan Gumukmas Multifarm (GMF)</h2>
                    <p class="text-body font-bold text-orange mb-6 leading-relaxed xl:text-title2">Apa saja layanan yang
                        kami sediakan?
                    </p>
                </div>
                <div class="w-full md:w-1/2 order-2">
                    <p class="text-body text-tblack leading-relaxed md:text-lwhite md:pl-8 xl:text-title2">
                        Kami menawarkan berbagai layanan yang dirancang untuk mendukung
                        kesuksesan peternakan Anda. Mulai dari kemitraan domba hingga
                        produksi pakan ternak berkualitas tinggi, kami berkomitmen untuk
                        memberikan solusi terbaik bagi peternak. Dengan layanan yang unggul
                        kami yang dapat membantu meningkatkan produktivitas dan efisiensi
                        usaha peternakan Anda.
                    </p>
                </div>
            </div>
        </div>

        <div class="hidden md:flex absolute top-0 right-0 w-1/2 bg-dgreen mt-9 h-80 items-center justify-center z-0"
            style="background-image: url('{{ asset('images/footer/footer.png') }}');">
        </div>

        <div class="container flex items-center mt-8 justify-center mx-auto relative z-20">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                {{-- Service 1 --}}
                <a href="https://www.youtube.com/watch?v=0xWkmwYg0UI"
                    class="service-card rounded-xl shadow-lg px-6 py-8 bg-white block">
                    <div class="flex flex-col items-center">
                        <div class="rounded-full overflow-hidden p-4 shadow-md flex items-center justify-center">
                            <img class="h-auto" src="{{ asset('images/landingpage/layanan1.png') }}" alt="">
                        </div>
                        <div class="flex flex-col">
                            <p class="text-title2 text-left text-dgreen mt-6 font-bold">Kemitraan Domba Gumukmas
                                Multifarm (GMF)</p>
                            <p class="text-body text-tblack mt-4 leading-relaxed">
                                Bersama GMF, raih peluang kemitraan dengan sistem yang transparan dan menguntungkan.
                                Kami menyediakan bimbingan dan dukungan penuh untuk memastikan kesuksesan usaha Anda
                            </p>
                        </div>
                    </div>
                </a>
                {{-- Service 2 --}}
                <a href="https://www.youtube.com/watch?v=rjs8j9z7uIE"
                    class="service-card rounded-xl shadow-lg px-6 py-8 bg-white block">
                    <div class="flex flex-col items-center">
                        <div class="rounded-full overflow-hidden p-4 shadow-md flex items-center justify-center">
                            <img class="h-auto" src="{{ asset('images/landingpage/layanan2.png') }}" alt="">
                        </div>
                        <div class="flex flex-col">
                            <p class="text-title2 text-left text-dgreen mt-6 font-bold">Domba Pejantan & Indukan
                                Kualitas Unggul</p>
                            <p class="text-body text-tblack mt-4 leading-relaxed">
                                Kami menyediakan domba pejantan dan indukan unggul untuk mendukung program
                                pengembangbiakan domba Anda. Kualitas ternak kami terjamin, sehat, dan produktif.
                            </p>
                        </div>
                    </div>
                </a>
                {{-- Service 3 --}}
                <a href="https://www.youtube.com/watch?v=Vl-aqpgYKFM"
                    class="service-card rounded-xl shadow-lg px-6 py-8 bg-white block">
                    <div class="flex flex-col items-center">
                        <div class="rounded-full overflow-hidden p-4 shadow-md flex items-center justify-center">
                            <img class="h-auto" src="{{ asset('images/landingpage/layanan3.png') }}" alt="">
                        </div>
                        <div class="flex flex-col">
                            <p class="text-title2 text-left text-dgreen mt-6 font-bold">Pengadaan Bahan Baku Pakan
                                Ternak</p>
                            <p class="text-body text-tblack mt-4 leading-relaxed">
                                Dapatkan bahan baku pakan ternak terbaik dari kami. Kami menjamin kualitas dan ketepatan
                                waktu pengiriman untuk memenuhi kebutuhan ternak Anda.
                            </p>
                        </div>
                    </div>
                </a>
                {{-- Service 4 --}}
                <a href="https://www.youtube.com/watch?v=4q7knADADUs"
                    class="service-card rounded-xl shadow-lg px-6 py-8 bg-white block">
                    <div class="flex flex-col items-center">
                        <div class="rounded-full overflow-hidden p-4 shadow-md flex items-center justify-center">
                            <img class="h-auto" src="{{ asset('images/landingpage/layanan4.png') }}" alt="">
                        </div>
                        <div class="flex flex-col">
                            <p class="text-title2 text-left text-dgreen mt-6 font-bold">Produksi Pakan Ternak Ruminansia
                                Kualitas Unggul</p>
                            <p class="text-body text-tblacks mt-4 leading-relaxed">
                                Kami memproduksi pakan ternak ruminansia dengan formulasi yang optimal untuk kesehatan
                                dan produktivitas ternak Anda. Produk kami terbuat dari bahan-bahan berkualitas tinggi
                                dan sudah teruji.
                            </p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </section>
    {{-- End Service section --}}

    {{-- Start Section Testimonial --}}
    <section id="" class="py-16 relative">
        <div class="container mx-auto relative z-10">
            <div class="flex-1 flex items-center">
                <div class="text-center mx-auto mt-8">
                    <h1 class="text-h3 font-bold text-white xl:text-h2">Apa Kata Mereka</h1>
                    <h1 class="text-h3 font-bold text-white xl:text-h2 mb-4">Tentang Gumukmas Multifarm ?</h1>
                    <p class="text-body text-text text-white xl:text-title2">Dengarkan pengalaman para peternak yang
                        telah
                        merasakan
                        manfaat dari kemitraan dengan Gumukmas Multifarm (GMF). Kami bangga dengan hubungan yang kami
                        bangun dan hasil yang telah dicapai bersama mitra-mitra kami. Berikut adalah beberapa testimoni
                        dari mereka yang telah bekerja sama dengan kami dan merasakan perbedaan nyata dalam usaha
                        peternakan mereka.</p>
                </div>
            </div>
        </div>
        <div class="absolute top-0 right-0 w-full h-3/5 bg-dgreen mt-9 flex items-center justify-center z-0"
            style="background-image: url('{{ asset('images/footer/footer.png') }}');">
        </div>
        <div class="container flex items-center p-8 justify-center mx-auto relative z-20">
            <div class="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-3 gap-4">
                {{-- Testimoni 1 --}}
                <div class="rounded-xl shadow-lg bg-white">
                    <div class="mt-7 ml-6"><img src="{{ asset('images/landingpage/quote.png') }}" alt="">
                    </div>
                    <div class="p-6 flex flex-col items-center">
                        <p class="text-body text-tblack">
                            Saya sangat puas dengan pakan ternak dari GMF. Sebelum mengenal GMF, saya sering mengalami
                            masalah dengan kualitas pakan yang tidak konsisten. Namun, sejak menggunakan pakan dari GMF,
                            saya melihat perubahan signifikan pada kesehatan dan produktivitas ternak saya. Selain itu,
                            layanan pengiriman mereka selalu tepat waktu, sehingga saya tidak pernah kekurangan stok
                            pakan. Tim GMF juga selalu siap memberikan saran mengenai formulasi pakan yang tepat untuk
                            kebutuhan ternak saya. Layanan pelanggan mereka sangat responsif dan ramah.</p>
                    </div>
                    <div class="border-t border-lwhite"></div>
                    <div class="max-w-sm mx-auto bg-transparent p-6 flex items-center space-x-4">
                        <img class="w-13 h-13 rounded-full" src="{{ asset('images/landingpage/profile.png') }}"
                            alt="Profile Picture">
                        <div>
                            <div class="text-body font-bold text-tblack">Santoso Budi</div>
                            <p class="text-body text-tgrey">Peternak uang</p>
                        </div>
                    </div>
                </div>
                {{-- Testimoni 2 --}}
                <div class="rounded-xl shadow-lg bg-white">
                    <div class="mt-7 ml-6"><img src="{{ asset('images/landingpage/quote.png') }}" alt="">
                    </div>
                    <div class="p-6 flex flex-col items-center">
                        <p class="text-body text-tblack">
                            Saya sangat puas dengan pakan ternak dari GMF. Sebelum mengenal GMF, saya sering mengalami
                            masalah dengan kualitas pakan yang tidak konsisten. Namun, sejak menggunakan pakan dari GMF,
                            saya melihat perubahan signifikan pada kesehatan dan produktivitas ternak saya. Selain itu,
                            layanan pengiriman mereka selalu tepat waktu, sehingga saya tidak pernah kekurangan stok
                            pakan. Tim GMF juga selalu siap memberikan saran mengenai formulasi pakan yang tepat untuk
                            kebutuhan ternak saya. Layanan pelanggan mereka sangat responsif dan ramah.</p>
                    </div>
                    <div class="border-t border-lwhite"></div>
                    <div class="max-w-sm mx-auto bg-transparent p-6 flex items-center space-x-4">
                        <img class="w-13 h-13 rounded-full" src="{{ asset('images/landingpage/profile.png') }}"
                            alt="Profile Picture">
                        <div>
                            <div class="text-body font-bold text-tblack">Siti Aminah</div>
                            <p class="text-body text-tgrey">Peternak Ayam Migrasi ke Domba</p>
                        </div>
                    </div>
                </div>
                {{-- Testimoni 3 --}}
                <div class="rounded-xl shadow-lg bg-white">
                    <div class="mt-7 ml-6"><img src="{{ asset('images/landingpage/quote.png') }}" alt="">
                    </div>
                    <div class="p-6 flex flex-col items-center">
                        <p class="text-body text-tblack">
                            Kerjasama dengan GMF telah membawa banyak manfaat bagi bisnis saya. Sebelum bergabung, saya
                            kesulitan menemukan domba unggul yang produktif dan sehat. GMF menyediakan domba pejantan
                            dan indukan berkualitas tinggi yang sangat produktif. Mereka juga memberikan bimbingan
                            teknis yang sangat membantu dalam meningkatkan manajemen peternakan saya. Pelayanan mereka
                            sangat profesional dan ramah, membuat saya merasa dihargai sebagai mitra. GMF benar-benar
                            menjadi mitra yang dapat diandalkan dalam usaha peternakan saya.</p>
                    </div>
                    <div class="border-t border-lwhite"></div>
                    <div class="max-w-sm mx-auto bg-transparent p-6 flex items-center space-x-4">
                        <img class="w-13 h-13 rounded-full" src="{{ asset('images/landingpage/profile.png') }}"
                            alt="Profile Picture">
                        <div>
                            <div class="text-body font-bold text-tblack">Edi Athoillah</div>
                            <p class="text-body text-tgrey">Member Akademi Kripto</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Navigation Buttons -->
        <div class="flex justify-center mt-8 space-x-4">
            <button
                class="w-12 h-12 rounded-full border-solid border-1 border-orange bg-white text-orange flex items-center justify-center shadow-lg"
                id="prev-btn">
                &#8249;
            </button>
            <button class="w-12 h-12 rounded-full bg-orange text-white flex items-center justify-center shadow-lg"
                id="next-btn">
                &#8250;
            </button>
        </div>
    </section>
    {{-- End Section Testimonial --}}

    <section id="" class="py-16 relative">
        <div class="container mx-auto relative z-10">
            <div class="flex items-center justify-center">
                <div class="text-center">
                    <h1 class="text-h2 font-bold xl:text-h1 text-dgreen">Blog</h1>
                    <h1 class="text-h2 font-bold xl:text-h1 text-dgreen">Gumukmas Multifarm</h1>
                </div>
            </div>
        </div>
        <!-- New Layout Section -->
        <div class="container mx-auto mt-12">
            <div class="flex flex-col md:flex-row md:space-x-4">
                <div class="flex-1 mb-8 md:mb-0">
                    <a href="#">
                        <div class="rounded-xl mb-6 shadow-lg bg-transparent flex-shrink-0 w-full hover:bg-white transition ease-in-out duration-300 transform hover:scale-105">

                        <div class="rounded-xl shadow-sm overflow-hidden">
                            <img src="{{ asset('images/blog/pexels-dmytro-mamon-256046-977239 1.png') }}"
                                alt="" class="w-full">
                        </div>
                        <div class="p-6">
                            <div class="flex items-center mb-6">
                                <img src="{{ asset('images/blog/clock.png') }}" class="w-4 h-4">
                                <p class="text-body flex px-2">16 Mei 2024</p>
                            </div>
                            <p class="text-title2 font-bold mb-6">CARA CEPAT PEMBIBITAN DOMBA DENGAN MODEL LOOSE
                                HOUSING</p>
                            <p class="text-body mb-8">GMF telah menjadi mitra yang luar biasa bagi usaha peternakan
                                saya. Dukungan dan kualitas ternak yang mereka berikan sungguh luar biasa.</p>
                            <div class="flex items-center">
                                <a href="" class="text-title2 font-bold underline">Baca Selengkapnya</a>
                                <img src="{{ asset('images/blog/arrow.png') }}" class="w-5 h-4 ml-2" alt="">
                            </div>
                        </div>
                    </div>

                    </a>
                </div>
                <div class="flex-1 mb-8 md:mb-0">
                    <a href="#">
                        <div class="rounded-xl mb-6 shadow-lg bg-transparent flex-shrink-0 w-full hover:bg-white transition ease-in-out duration-300 transform hover:scale-105">
                        <div class="rounded-xl shadow-sm overflow-hidden">
                            <img src="{{ asset('images/blog/pexels-jenny-k-181141-587411 1.png') }}" alt=""
                                class="w-full">
                        </div>
                        <div class="p-6">
                            <div class="flex items-center mb-6">
                                <img src="{{ asset('images/blog/clock.png') }}" class="w-4 h-4">
                                <p class="text-body flex px-2">16 Mei 2024</p>
                            </div>
                            <p class="text-title2 font-bold mb-6">CARA CEPAT PEMBIBITAN DOMBA DENGAN MODEL LOOSE
                                HOUSING</p>
                            <p class="text-body mb-8">GMF telah menjadi mitra yang luar biasa bagi usaha peternakan
                                saya. Dukungan dan kualitas ternak yang mereka berikan sungguh luar biasa.</p>
                            <div class="flex items-center">
                                <a href="" class="text-title2 font-bold underline">Baca Selengkapnya</a>
                                <img src="{{ asset('images/blog/arrow.png') }}" class="w-5 h-4 ml-2" alt="">
                            </div>
                        </div>
                    </div>
                    </a>
                </div>
                <div class="flex-1 mb-8 md:mb-0">
                    <!-- Artikel Pertama -->
                    <a href="http://">
                        <div class="rounded-xl mb-6 shadow-lg bg-transparent flex-shrink-0 w-full hover:bg-white transition ease-in-out duration-300 transform hover:scale-105">
                            <div class="flex flex-row items-center">
                                <img src="{{ asset('images/blog/pexels-katlovessteve-678451 1.png') }}"
                                    class="rounded-xl w-32 h-28" alt="">
                                <div class="mx-3">
                                    <div class="flex items-center">
                                        <img src="{{ asset('images/blog/clock.png') }}" class="w-4 h-4">
                                        <p class="text-body flex px-2">16 Mei 2024</p>
                                    </div>
                                    <p class="text-body font-bold mt-2">ATASI VIRUS PMK DENGAN DESINFEKSI DAN SANITASI
                                        KANDANG SECARA RUTIN</p>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- Artikel Kedua -->
                    <a href="http://" class="">
                        <div class="rounded-xl mb-6 shadow-lg bg-transparent flex-shrink-0 w-full hover:bg-white transition ease-in-out duration-300 transform hover:scale-105">
                            <div class="flex flex-row items-center">
                                <img src="{{ asset('images/blog/pexels-maca-naparstek-456152-1153756 1.png') }}"
                                    class="rounded-xl w-32 h-28" alt="">
                                <div class="mx-3">
                                    <div class="flex items-center">
                                        <img src="{{ asset('images/blog/clock.png') }}" class="w-4 h-4">
                                        <p class="text-body flex px-2">16 Mei 2024</p>
                                    </div>
                                    <p class="text-body font-bold mt-2">ATASI VIRUS PMK DENGAN DESINFEKSI DAN SANITASI
                                        KANDANG SECARA RUTIN</p>
                                </div>
                            </div>
                        </div>
                    </a>
                
                    <!-- Artikel Ketiga -->
                    <a href="">
                        <div class="rounded-xl mb-6 shadow-lg bg-transparent flex-shrink-0 w-full hover:bg-white transition ease-in-out duration-300 transform hover:scale-105">
                            <div class="flex flex-row items-center">
                                <img src="{{ asset('images/blog/pexels-pixabay-37657 1.png') }}"
                                    class="rounded-xl w-32 h-28" alt="">
                                <div class="mx-3">
                                    <div class="flex items-center">
                                        <img src="{{ asset('images/blog/clock.png') }}" class="w-4 h-4">
                                        <p class="text-body flex px-2">16 Mei 2024</p>
                                    </div>
                                    <p class="text-body font-bold mt-2">ATASI VIRUS PMK DENGAN DESINFEKSI DAN SANITASI
                                        KANDANG SECARA RUTIN</p>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                
            </div>
        </div>
    </section>

    <script>
        document.getElementById('prev-btn').addEventListener('click', function() {});

        document.getElementById('next-btn').addEventListener('click', function() {});
    </script>
    @livewire('components.footer')
    @vite('resources/js/app.js')
    <script src="{{ asset('assets/script.js') }}"></script>
</body>

</html>
