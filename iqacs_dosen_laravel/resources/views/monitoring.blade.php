@extends('main')
@section('content')
<!-- cards row 3 -->
<div class="flex flex-wrap my-6 -mx-3">
    <!-- cards row 3 -->
    <div class="w-full max-w-full px-3 mt-0 mb-6 md:mb-0 md:w-1/2 md:flex-none lg:w-2/3 lg:flex-none">
        <div class="border-black/12.5 shadow-soft-xl relative z-20 flex min-w-0 flex-col break-words rounded-2xl border-0 border-solid bg-white bg-clip-border">
            <div class="border-black/12.5 mb-0 rounded-t-2xl border-b-0 border-solid bg-white p-6 pb-0">
                <h6>Chart Data</h6>
            </div>
            <div class="border-black/12.5 mb-0 text-center rounded-t-2xl border-b-0 border-solid bg-white p-6 pb-0">
                <h6>Karbon Dioksida (CO2)</h6>
            </div>
            <div class="flex-auto p-4">
                <!-- Chart 1 -->
                <div id="chart">
                </div>
            </div>
            <div class="border-black/12.5 mb-0 text-center rounded-t-2xl border-b-0 border-solid bg-white p-6 pb-0">
                <h6>Metana (CH4)</h6>
            </div>
        <div class="flex-auto p-4">
                <!-- Chart 1 -->
                <div id="chart">
                </div>
        </div>
    </div>
</div>
@endsection
