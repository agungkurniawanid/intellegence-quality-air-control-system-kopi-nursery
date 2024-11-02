<aside class="text-white w-52 flex-shrink-0 hidden lg:block "
    style="background-image: url('{{ asset('assets/sidebar-bg.png') }}');">
    <div class="flex items-center justify-between pt-8 pb-4">
        <a class="flex items-center justify-center w-full" href="#">
            <div class="flex-1 flex justify-center items-center">
                <div>
                    <img src="{{ asset('images/logo-kopi.png') }}"
                        class="inline h-10 w-10 transition-all duration-200 ease-nav-brand" alt="main_logo" />
                </div>
                <div class="ml-2">
                    <span
                        class="block font-semibold text-lwhite transition-all text-body duration-200 mr-4">KOPI</span>
                    <span
                        class="block font-semibold text-lwhite transition-all text-body duration-200 mr-4">NURSERY</span>
                </div>
            </div>
        </a>
    </div>
    <nav class="px-2 py-2">
        <ul class="space-y-2 font-medium">
            <li>
                <a href="{{ route('dashboard') }}"
                    class="flex items-center block py-2 text-white text-body hover:text-brown-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20"
                        fill="currentColor">
                        <path
                            d="M4 11a1 1 0 1 1 2 0v1a1 1 0 1 1-2 0zm6-4a1 1 0 1 1 2 0v5a1 1 0 1 1-2 0zM7 9a1 1 0 0 1 2 0v3a1 1 0 1 1-2 0z" />
                        <path
                            d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1z" />
                        <path
                            d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0z" />
                    </svg>
                    Monitoring
                </a>
            </li>
            <li>
                <a type="button"
                    class="flex items-center block py-2 text-white text-body hover:text-brown-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200"
                    aria-controls="dropdown-example" data-collapse-toggle="dropdown-example">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20"
                        fill="currentColor">
                        <path
                            d="M12 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2M5 4h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1m-.5 2.5A.5.5 0 0 1 5 6h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1-.5-.5M5 8h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1m0 2h3a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1" />
                    </svg>
                    Rekam Data<svg class="w-2.5 h-2.5 ms-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                        fill="none" viewBox="0 0 10 6">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="m1 1 4 4 4-4" />
                    </svg>
                </a>
                <ul id="dropdown-example" class="hidden">
                    <li>
                        <a href="{{ route('riwayat.temperature') }}"
                            class="flex items-center block mx-2 py-1 text-white text-body hover:text-brown-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                            Temperature
                        </a>
                    </li>
                    <li>
                        <a href="{{ route('riwayat.humidity') }}"
                            class="flex items-center block mx-2 py-1 text-white text-body hover:text-brown-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                            Humidity
                        </a>
                    </li>
                    <!-- {{-- <li>
                        <a href="{{ route('riwayat.amonia') }}"
                            class="flex items-center block mx-2 py-1 text-white text-body hover:text-brown-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                           Amonia
                        </a>
                    </li> --}}
                    {{-- <li>
                        <a href="{{ route('riwayat.metana') }}"
                            class="flex items-center block mx-2 py-1 text-white text-body hover:text-brown-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                           Metana
                        </a>
                    </li> --}}
                    {{-- <li>
                        <a href="{{ route('riwayat.dioksida') }}"
                            class="flex items-center block mx-2 py-1 text-white text-body hover:text-brown-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                           Karbon Dioksida
                        </a>
                    </li> --}} -->
                </ul>
            </li>
            @if (Auth::user()->role == 'admin')
            <li>
                <a href="{{ route('karyawan') }}"
                    class="flex items-center block py-2 text-white text-body hover:text-brown-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20"
                        fill="currentColor">
                        <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" />
                        <path
                            d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1v-1c0-1-1-4-6-4s-6 3-6 4v1a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z" />
                    </svg>
                    Data Karyawan
                </a>
            </li>
            @else
            @endif
            <li>
                <a href="{{ route('blog') }}"
                    class="flex items-center block py-2 text-white text-body hover:text-brown-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20"
                        fill="currentColor">
                        <path
                            d="M5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5" />
                        <path
                            d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2" />
                        <path
                            d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1z" />
                    </svg>
                    Blog
                </a>
            </li>
        </ul>
    </nav>
</aside>
