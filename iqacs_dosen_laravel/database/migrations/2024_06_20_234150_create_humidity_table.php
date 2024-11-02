<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('humidity', function (Blueprint $table) {
            $table->id();
            // $table->unsignedInteger('id_alat')->length(3);
            $table->decimal('nilai_humidity', 5, 2);
            $table->timestamps();
            // $table->foreign('id_alat')->references('id_alat')->on('alat')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('humidity');
    }
};
