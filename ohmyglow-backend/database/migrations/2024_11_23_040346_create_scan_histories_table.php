<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('scan_histories', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade'); // Relasi ke tabel users
            $table->foreignId('disease_id')->constrained()->onDelete('cascade'); // Relasi ke tabel diseases
            $table->string('image_path'); // Lokasi gambar hasil scan
            $table->decimal('confidence_score', 5, 2); // Skor kepercayaan untuk diagnosis
            $table->date('scan_date'); // Tanggal pemindaian
            $table->timestamps(); // Kolom created_at dan updated_at
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('scan_histories');
    }
};
